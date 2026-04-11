import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:job_application_tracker/core/applications/swipe_status_actions.dart';
import 'package:job_application_tracker/core/models/job_application.dart';
import 'package:job_application_tracker/core/models/job_application_status.dart';
import 'package:job_application_tracker/data/isar/app_isar.dart';
import 'package:job_application_tracker/data/isar/isar_schemas.dart';
import 'package:job_application_tracker/data/isar/job_application_isar_mapper.dart';
import 'package:job_application_tracker/data/isar/legacy_prefs_importer.dart';

void main() {
  test(
    'LegacyPrefsImporter copies prefs into Isar, clears keys, idempotent',
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      final JobApplication app = JobApplication(
        id: 'id1',
        postingUrl: 'https://example.com/j',
        jobTitle: 'Dev',
        companyName: 'Co',
        submittedOn: DateTime(2025, 2, 1),
        status: JobApplicationStatus.draft,
      );
      final String payload = jsonEncode(<String, dynamic>{
        'applications': <Map<String, dynamic>>[app.toJson()],
      });
      SharedPreferences.setMockInitialValues(<String, Object>{
        'job_applications_v1': payload,
        'theme_mode': 'dark',
        'language_code': 'fr',
        'swipe_start_pane_v1': swipeActionAdvanceStorageValue,
        'swipe_end_pane_v1': 'closedNotSelected',
        'waiting_followup_days_v1': 12,
        'user_profile_v1': '{"displayName":"Ada"}',
        'draft_reminder_notification_ids_v1': <String>['1', '2'],
        'waiting_followup_notification_ids_v1': <String>['3'],
      });
      final prefs = await SharedPreferences.getInstance();
      final Directory dir = await Directory.systemTemp.createTemp('mig_');
      final Isar isar = await openJobTrackIsarInDirectory(dir.path, name: 'm1');
      await ensureIsarSingletonDefaults(isar);
      await LegacyPrefsImporter.migrateIfNeeded(isar, prefs);

      final List<JobApplicationEntity> loaded = isar.jobApplicationEntitys
          .where()
          .findAllSync();
      expect(loaded.length, 1);
      expect(jobApplicationFromEntity(loaded.single).id, 'id1');

      final AppSettingsEntity settings = isar.appSettingsEntitys
          .getByRowKeySync(kSingletonSettings)!;
      expect(settings.themeMode, 'dark');
      expect(settings.languageCode, 'fr');
      expect(settings.swipeEndPane, 'closedNotSelected');
      expect(settings.waitingFollowUpDays, 12);

      final UserProfileEntity profile = isar.userProfileEntitys.getByRowKeySync(
        kSingletonProfile,
      )!;
      expect(profile.profileJson.contains('Ada'), isTrue);

      final NotificationStateEntity notif = isar.notificationStateEntitys
          .getByRowKeySync(kSingletonNotificationState)!;
      expect(notif.draftTrackedNotificationIds, <int>[1, 2]);
      expect(notif.waitingTrackedNotificationIds, <int>[3]);

      expect(prefs.getString('job_applications_v1'), isNull);
      expect(prefs.getString('theme_mode'), isNull);

      final AppMetaEntity meta = isar.appMetaEntitys.getByRowKeySync(
        kSingletonMeta,
      )!;
      expect(meta.prefsMigrationV1Complete, isTrue);

      await LegacyPrefsImporter.migrateIfNeeded(isar, prefs);

      await isar.close(deleteFromDisk: true);
      await dir.delete(recursive: true);
    },
  );
}
