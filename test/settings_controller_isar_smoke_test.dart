import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

import 'package:job_application_tracker/core/settings/app_background_kind.dart';
import 'package:job_application_tracker/core/settings/app_background_presets.dart';
import 'package:job_application_tracker/core/settings/settings_controller.dart';

import 'isar_test_support.dart';

void main() {
  test('SettingsController writes language to Isar', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final EphemeralIsar h = await openEphemeralJobTrackIsar();
    try {
      final String bgDir = p.join(h.dir.path, 'backgrounds');
      await Directory(bgDir).create(recursive: true);
      final SettingsController s = SettingsController(
        h.isar,
        backgroundsDirectoryPath: bgDir,
      );
      await s.setLanguageCode('fr');
      expect(s.languageCodeKey, 'fr');
    } finally {
      await closeEphemeralIsar(h.isar, h.dir);
    }
  });

  test('SettingsController persists wallpaper gradient preset', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final EphemeralIsar h = await openEphemeralJobTrackIsar();
    try {
      final String bgDir = p.join(h.dir.path, 'backgrounds');
      await Directory(bgDir).create(recursive: true);
      final SettingsController s = SettingsController(
        h.isar,
        backgroundsDirectoryPath: bgDir,
      );
      await s.setAppBackgroundGradient(AppBackgroundPresets.sunsetId);
      expect(s.appBackgroundKind, AppBackgroundKind.gradient);
      expect(s.appBackgroundPresetId, AppBackgroundPresets.sunsetId);
      expect(s.wallpaperActive, isTrue);
      final SettingsController s2 = SettingsController(
        h.isar,
        backgroundsDirectoryPath: bgDir,
      );
      expect(s2.appBackgroundKind, AppBackgroundKind.gradient);
      expect(s2.appBackgroundPresetId, AppBackgroundPresets.sunsetId);
    } finally {
      await closeEphemeralIsar(h.isar, h.dir);
    }
  });
}
