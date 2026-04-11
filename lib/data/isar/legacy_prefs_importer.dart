import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:job_application_tracker/core/applications/swipe_status_actions.dart';
import 'package:job_application_tracker/core/models/job_application.dart';
import 'package:job_application_tracker/data/isar/isar_schemas.dart';
import 'package:job_application_tracker/data/isar/job_application_isar_mapper.dart';

/// SharedPreferences keys used before Isar migration (must stay stable).
abstract final class LegacyPrefsKeys {
  static const String jobApplications = 'job_applications_v1';
  static const String themeMode = 'theme_mode';
  static const String languageCode = 'language_code';
  static const String swipeStartPane = 'swipe_start_pane_v1';
  static const String swipeEndPane = 'swipe_end_pane_v1';
  static const String waitingFollowUpDays = 'waiting_followup_days_v1';
  static const String userProfile = 'user_profile_v1';
  static const String draftReminderIds = 'draft_reminder_notification_ids_v1';
  static const String waitingReminderIds = 'waiting_followup_notification_ids_v1';
}

class LegacyPrefsImporter {
  LegacyPrefsImporter._();

  static Future<void> migrateIfNeeded(Isar isar, SharedPreferences prefs) async {
    final AppMetaEntity? metaEarly =
        isar.appMetaEntitys.getByRowKeySync(kSingletonMeta);
    if (metaEarly != null && metaEarly.prefsMigrationV1Complete) {
      return;
    }

    await isar.writeTxn(() async {
      final String? appsRaw = prefs.getString(LegacyPrefsKeys.jobApplications);
      if (appsRaw != null && appsRaw.isNotEmpty) {
        try {
          final Map<String, dynamic> decoded =
              jsonDecode(appsRaw) as Map<String, dynamic>;
          final List<dynamic>? list = decoded['applications'] as List<dynamic>?;
          if (list != null) {
            for (final dynamic e in list) {
              if (e is! Map<String, dynamic>) {
                continue;
              }
              final JobApplication app = JobApplication.fromJson(e);
              await isar.jobApplicationEntitys.put(jobApplicationToEntity(app));
            }
          }
        } catch (_) {}
      }

      final AppSettingsEntity? settings = await isar.appSettingsEntitys
          .filter()
          .rowKeyEqualTo(kSingletonSettings)
          .findFirst();
      if (settings != null) {
        final String? tm = prefs.getString(LegacyPrefsKeys.themeMode);
        if (tm != null && tm.isNotEmpty) {
          settings.themeMode = tm;
        }
        final String? lc = prefs.getString(LegacyPrefsKeys.languageCode);
        if (lc != null && lc.isNotEmpty) {
          settings.languageCode = lc;
        }
        final String? ss = prefs.getString(LegacyPrefsKeys.swipeStartPane);
        if (ss != null && ss.isNotEmpty) {
          settings.swipeStartPane = ss;
        } else {
          settings.swipeStartPane = swipeActionAdvanceStorageValue;
        }
        final String? se = prefs.getString(LegacyPrefsKeys.swipeEndPane);
        if (se != null && se.isNotEmpty) {
          settings.swipeEndPane = se;
        } else {
          settings.swipeEndPane = 'closedNotSelected';
        }
        final int? wd = prefs.getInt(LegacyPrefsKeys.waitingFollowUpDays);
        if (wd != null) {
          settings.waitingFollowUpDays = wd.clamp(3, 30);
        }
        await isar.appSettingsEntitys.put(settings);
      }

      final String? profileRaw = prefs.getString(LegacyPrefsKeys.userProfile);
      if (profileRaw != null && profileRaw.isNotEmpty) {
        try {
          jsonDecode(profileRaw) as Map<String, dynamic>;
          final UserProfileEntity? pe = await isar.userProfileEntitys
              .filter()
              .rowKeyEqualTo(kSingletonProfile)
              .findFirst();
          if (pe != null) {
            pe.profileJson = profileRaw;
            await isar.userProfileEntitys.put(pe);
          }
        } catch (_) {}
      }

      final List<String>? draftIds =
          prefs.getStringList(LegacyPrefsKeys.draftReminderIds);
      final List<String>? waitIds =
          prefs.getStringList(LegacyPrefsKeys.waitingReminderIds);
      if (draftIds != null || waitIds != null) {
        final NotificationStateEntity? ne = await isar.notificationStateEntitys
            .filter()
            .rowKeyEqualTo(kSingletonNotificationState)
            .findFirst();
        if (ne != null) {
          if (draftIds != null) {
            ne.draftTrackedNotificationIds = draftIds
                .map(int.tryParse)
                .whereType<int>()
                .toList();
          }
          if (waitIds != null) {
            ne.waitingTrackedNotificationIds = waitIds
                .map(int.tryParse)
                .whereType<int>()
                .toList();
          }
          await isar.notificationStateEntitys.put(ne);
        }
      }

      final AppMetaEntity? metaRow = await isar.appMetaEntitys
          .filter()
          .rowKeyEqualTo(kSingletonMeta)
          .findFirst();
      final AppMetaEntity metaOut =
          metaRow ??
          (AppMetaEntity()
            ..rowKey = kSingletonMeta
            ..prefsMigrationV1Complete = false);
      metaOut.prefsMigrationV1Complete = true;
      await isar.appMetaEntitys.put(metaOut);
    });

    await prefs.remove(LegacyPrefsKeys.jobApplications);
    await prefs.remove(LegacyPrefsKeys.themeMode);
    await prefs.remove(LegacyPrefsKeys.languageCode);
    await prefs.remove(LegacyPrefsKeys.swipeStartPane);
    await prefs.remove(LegacyPrefsKeys.swipeEndPane);
    await prefs.remove(LegacyPrefsKeys.waitingFollowUpDays);
    await prefs.remove(LegacyPrefsKeys.userProfile);
    await prefs.remove(LegacyPrefsKeys.draftReminderIds);
    await prefs.remove(LegacyPrefsKeys.waitingReminderIds);
  }
}
