import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:job_application_tracker/app/crash_diagnostics.dart';
import 'package:job_application_tracker/app/job_track_app.dart';
import 'package:job_application_tracker/app/startup_failure_app.dart';
import 'package:job_application_tracker/core/applications/applications_controller.dart';
import 'package:job_application_tracker/core/notifications/draft_apply_reminder_scheduler.dart';
import 'package:job_application_tracker/core/notifications/notification_bootstrap.dart';
import 'package:job_application_tracker/core/notifications/waiting_followup_reminder_scheduler.dart';
import 'package:job_application_tracker/core/profile/profile_controller.dart';
import 'package:job_application_tracker/core/settings/settings_controller.dart';
import 'package:job_application_tracker/data/isar/app_isar.dart';
import 'package:job_application_tracker/data/isar/legacy_prefs_importer.dart';
import 'package:job_application_tracker/features/shell/app_navigation_bridge.dart';

bool _jobTrackUiLaunched = false;

void _runStartupFailureApp(Object error, StackTrace stackTrace) {
  if (_jobTrackUiLaunched) {
    return;
  }
  _jobTrackUiLaunched = true;
  runApp(
    StartupFailureApp(
      error: error,
      stackTrace: stackTrace,
      logFilePath: CrashDiagnostics.logFilePath ?? '(unavailable)',
    ),
  );
}

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await CrashDiagnostics.install();

      try {
        final prefs = await SharedPreferences.getInstance();
        final isar = await openJobTrackIsar();
        await ensureIsarSingletonDefaults(isar);
        final Directory supportDir = await getApplicationSupportDirectory();
        final String backgroundsDirectoryPath = p.join(
          supportDir.path,
          'backgrounds',
        );
        await Directory(backgroundsDirectoryPath).create(recursive: true);
        await LegacyPrefsImporter.migrateIfNeeded(isar, prefs);
        final notifPlugin = await setupLocalNotifications();
        final draftReminderScheduler = DraftApplyReminderScheduler(
          plugin: notifPlugin,
          isar: isar,
        );
        final waitingFollowUpReminderScheduler = WaitingFollowUpReminderScheduler(
          plugin: notifPlugin,
          isar: isar,
        );
        final profileController = ProfileController(isar);
        await profileController.init();
        final applicationsController = ApplicationsController(
          isar,
          onApplicationsPersisted: (apps) async {
            await draftReminderScheduler.syncFromApplications(apps);
            await waitingFollowUpReminderScheduler.syncFromApplications(apps);
          },
        );
        await applicationsController.init();
        await draftReminderScheduler.syncFromApplications(
          applicationsController.applications,
        );
        await waitingFollowUpReminderScheduler.syncFromApplications(
          applicationsController.applications,
        );
        if (_jobTrackUiLaunched) {
          return;
        }
        _jobTrackUiLaunched = true;
        runApp(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<SettingsController>(
                create: (_) => SettingsController(
                  isar,
                  backgroundsDirectoryPath: backgroundsDirectoryPath,
                  onWaitingFollowUpThresholdChanged: () async {
                    await waitingFollowUpReminderScheduler.syncFromApplications(
                      applicationsController.applications,
                    );
                  },
                ),
              ),
              ChangeNotifierProvider<ProfileController>.value(
                value: profileController,
              ),
              ChangeNotifierProvider<ApplicationsController>.value(
                value: applicationsController,
              ),
              ChangeNotifierProvider<AppNavigationBridge>(
                create: (_) => AppNavigationBridge(),
              ),
            ],
            child: const JobTrackApp(),
          ),
        );
      } catch (e, st) {
        await CrashDiagnostics.record(e, st, label: 'bootstrap');
        _runStartupFailureApp(e, st);
      }
    },
    (Object error, StackTrace stackTrace) {
      CrashDiagnostics.recordSync(error, stackTrace, label: 'zone');
      _runStartupFailureApp(error, stackTrace);
    },
  );
}
