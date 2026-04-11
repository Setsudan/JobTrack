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

class WaitingFollowUpReminderScheduler {
  WaitingFollowUpReminderScheduler({
    required FlutterLocalNotificationsPlugin plugin,
    required Isar isar,
  }) : _plugin = plugin,
       _isar = isar;

  static const String _channelId = 'waiting_followup_reminders_v1';

  final FlutterLocalNotificationsPlugin _plugin;
  final Isar _isar;

  static int notificationId(JobApplication app) =>
      (app.id.hashCode ^ 0x615D82C1) & 0x7FFFFFFF;

  AppLocalizations _resolveL10n() {
    final code = PlatformDispatcher.instance.locale.languageCode;
    switch (code) {
      case 'fr':
        return AppLocalizationsFr();
      default:
        return AppLocalizationsEn();
    }
  }

  int _thresholdDays() {
    final AppSettingsEntity? s = _isar.appSettingsEntitys.getByRowKeySync(
      kSingletonSettings,
    );
    final int v = s?.waitingFollowUpDays ?? 7;
    if (v < 3) {
      return 3;
    }
    if (v > 30) {
      return 30;
    }
    return v;
  }

  bool _shouldSchedule(
    JobApplication application,
    DateTime today,
    int thresholdDays,
  ) {
    if (application.isArchived) {
      return false;
    }
    if (application.status != JobApplicationStatus.submitted &&
        application.status != JobApplicationStatus.noResponseYet) {
      return false;
    }
    final submitted = JobApplication.dateOnly(application.submittedOn);
    final days = today.difference(submitted).inDays;
    return days >= thresholdDays;
  }

  tz.TZDateTime _nextNineAmSlot(tz.TZDateTime nowLocal) {
    final today = JobApplication.dateOnly(DateTime.now());
    var atNine = tz.TZDateTime(tz.local, today.year, today.month, today.day, 9);
    if (!atNine.isAfter(nowLocal)) {
      final tomorrow = today.add(const Duration(days: 1));
      atNine = tz.TZDateTime(
        tz.local,
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        9,
      );
    }
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
    final Set<int> previous =
        (stateRow?.waitingTrackedNotificationIds ?? <int>[]).toSet();

    final today = JobApplication.dateOnly(DateTime.now());
    final nowLocal = tz.TZDateTime.now(tz.local);
    final threshold = _thresholdDays();

    final desired = <int>{};
    for (final JobApplication app in applications) {
      if (_shouldSchedule(app, today, threshold)) {
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
      l10n.notificationChannelWaitingFollowUpsName,
      channelDescription: l10n.notificationChannelWaitingFollowUpsDescription,
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

    final when = _nextNineAmSlot(nowLocal);

    for (final JobApplication app in applications) {
      if (!_shouldSchedule(app, today, threshold)) {
        continue;
      }
      final int nid = notificationId(app);
      final role = app.jobTitle.trim().isEmpty ? '-' : app.jobTitle.trim();
      final company = app.companyName.trim().isEmpty
          ? '-'
          : app.companyName.trim();
      try {
        await _plugin.zonedSchedule(
          id: nid,
          title: l10n.waitingFollowUpNotificationTitle,
          body: l10n.waitingFollowUpNotificationBody(role, company),
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
      row.waitingTrackedNotificationIds = desired.toList();
      await _isar.notificationStateEntitys.put(row);
    });
  }
}
