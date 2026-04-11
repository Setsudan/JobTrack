import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'package:job_application_tracker/l10n/app_localizations_en.dart';

Future<FlutterLocalNotificationsPlugin> setupLocalNotifications() async {
  final plugin = FlutterLocalNotificationsPlugin();
  if (kIsWeb) {
    return plugin;
  }

  tzdata.initializeTimeZones();
  try {
    final info = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(info.identifier));
  } catch (_) {
    tz.setLocalLocation(tz.UTC);
  }

  final linuxAction = AppLocalizationsEn().commonOk;
  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  const darwin = DarwinInitializationSettings();
  final settings = InitializationSettings(
    android: android,
    iOS: darwin,
    macOS: darwin,
    linux: LinuxInitializationSettings(defaultActionName: linuxAction),
    windows: const WindowsInitializationSettings(
      appName: 'JobTrack',
      appUserModelId: 'one.launay.job_application_tracker.jobtrack',
      guid: 'f11062e0-b398-4bbe-9bb2-1d2e7b326508',
    ),
  );

  try {
    await plugin.initialize(settings: settings);
  } catch (_) {
    return plugin;
  }

  if (defaultTargetPlatform == TargetPlatform.android) {
    try {
      await plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    } catch (_) {}
  }
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    try {
      await plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } catch (_) {}
  }
  if (defaultTargetPlatform == TargetPlatform.macOS) {
    try {
      await plugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } catch (_) {}
  }

  return plugin;
}
