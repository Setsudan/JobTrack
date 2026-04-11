import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:isar/isar.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:job_application_tracker/core/models/job_application.dart';
import 'package:job_application_tracker/core/models/job_application_status.dart';
import 'package:job_application_tracker/data/isar/isar_schemas.dart';
import 'package:job_application_tracker/l10n/app_localizations.dart';
import 'package:job_application_tracker/l10n/app_localizations_en.dart';
import 'package:job_application_tracker/l10n/app_localizations_fr.dart';

class DraftApplyReminderScheduler {
  DraftApplyReminderScheduler({
    required FlutterLocalNotificationsPlugin plugin,
    required Isar isar,
  }) : _plugin = plugin,
       _isar = isar;

  static const String _channelId = 'draft_apply_reminders_v1';

  final FlutterLocalNotificationsPlugin _plugin;
  final Isar _isar;

  static int notificationId(JobApplication app) => app.id.hashCode & 0x7FFFFFFF;

  AppLocalizations _resolveL10n() {
    final code = PlatformDispatcher.instance.locale.languageCode;
    switch (code) {
      case 'fr':
        return AppLocalizationsFr();
      default:
        return AppLocalizationsEn();
    }
  }

  bool _shouldSchedule(JobApplication application, DateTime today) {
    if (application.isArchived) {
      return false;
    }
    if (application.status != JobApplicationStatus.draft) {
      return false;
    }
    final reminderDay = JobApplication.dateOnly(application.submittedOn);
    return !reminderDay.isBefore(today);
  }

  tz.TZDateTime _scheduledMoment(DateTime reminderDay, tz.TZDateTime nowLocal) {
    final day = JobApplication.dateOnly(reminderDay);
    var atNine = tz.TZDateTime(tz.local, day.year, day.month, day.day, 9);
    if (!atNine.isAfter(nowLocal)) {
      atNine = nowLocal.add(const Duration(seconds: 12));
    }
    return atNine;
  }

  Future<void> syncFromApplications(List<JobApplication> applications) async {
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.linux) {
      return;
    }

    final l10n = _resolveL10n();
    final NotificationStateEntity? stateRow = _isar.notificationStateEntitys
        .getByRowKeySync(kSingletonNotificationState);
    final Set<int> previous = (stateRow?.draftTrackedNotificationIds ?? <int>[])
        .toSet();

    final today = JobApplication.dateOnly(DateTime.now());
    final nowLocal = tz.TZDateTime.now(tz.local);

    final desired = <int>{};
    for (final JobApplication app in applications) {
      if (_shouldSchedule(app, today)) {
        desired.add(notificationId(app));
      }
    }

    for (final int staleId in previous.difference(desired)) {
      try {
        await _plugin.cancel(id: staleId);
      } catch (_) {}
    }

    final androidDetails = AndroidNotificationDetails(
      _channelId,
      l10n.notificationChannelDraftRemindersName,
      channelDescription: l10n.notificationChannelDraftRemindersDescription,
    );
    const darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const windowsDetails = WindowsNotificationDetails();
    final details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
      macOS: darwinDetails,
      windows: windowsDetails,
    );

    for (final JobApplication app in applications) {
      if (!_shouldSchedule(app, today)) {
        continue;
      }
      final int nid = notificationId(app);
      final role = app.jobTitle.trim().isEmpty ? '-' : app.jobTitle.trim();
      final company = app.companyName.trim().isEmpty
          ? '-'
          : app.companyName.trim();
      final when = _scheduledMoment(app.submittedOn, nowLocal);
      try {
        await _plugin.zonedSchedule(
          id: nid,
          title: l10n.draftApplyReminderNotificationTitle,
          body: l10n.draftApplyReminderNotificationBody(role, company),
          scheduledDate: when,
          notificationDetails: details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          payload: app.id,
        );
      } catch (_) {}
    }

    await _isar.writeTxn(() async {
      final NotificationStateEntity? row = await _isar.notificationStateEntitys
          .filter()
          .rowKeyEqualTo(kSingletonNotificationState)
          .findFirst();
      if (row == null) {
        return;
      }
      row.draftTrackedNotificationIds = desired.toList();
      await _isar.notificationStateEntitys.put(row);
    });
  }
}
