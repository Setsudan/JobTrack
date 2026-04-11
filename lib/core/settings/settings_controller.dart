import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as p;

import 'package:job_application_tracker/core/applications/swipe_status_actions.dart';
import 'package:job_application_tracker/core/settings/app_appearance.dart';
import 'package:job_application_tracker/core/settings/app_background_kind.dart';
import 'package:job_application_tracker/core/settings/app_background_presets.dart';
import 'package:job_application_tracker/core/settings/background_image_import_result.dart';
import 'package:job_application_tracker/data/isar/isar_schemas.dart';

class SettingsController extends ChangeNotifier {
  SettingsController(
    this._isar, {
    required String backgroundsDirectoryPath,
    Future<void> Function()? onWaitingFollowUpThresholdChanged,
  })  : _backgroundsDirectoryPath = backgroundsDirectoryPath,
        _onWaitingFollowUpThresholdChanged = onWaitingFollowUpThresholdChanged {
    _hydrateFromIsar();
    unawaited(_repairInvalidBackgroundIfNeeded());
  }

  final Isar _isar;
  final String _backgroundsDirectoryPath;
  final Future<void> Function()? _onWaitingFollowUpThresholdChanged;

  AppAppearance _appearance = AppAppearance.system;
  Locale? _locale;

  AppAppearance get appearance => _appearance;

  ThemeMode get themeMode => _appearance.materialThemeMode;

  Locale? get locale => _locale;

  String get languageCodeKey {
    if (_locale == null) {
      return 'system';
    }
    return _locale!.languageCode;
  }

  String get swipeStartPaneAction {
    final AppSettingsEntity? s = _isar.appSettingsEntitys.getByRowKeySync(
      kSingletonSettings,
    );
    final String? raw = s?.swipeStartPane;
    if (raw == null || raw.isEmpty) {
      return swipeActionAdvanceStorageValue;
    }
    return raw;
  }

  String get swipeEndPaneAction {
    final AppSettingsEntity? s = _isar.appSettingsEntitys.getByRowKeySync(
      kSingletonSettings,
    );
    final String? raw = s?.swipeEndPane;
    if (raw == null || raw.isEmpty) {
      return 'closedNotSelected';
    }
    return raw;
  }

  int get waitingFollowUpDays {
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

  AppBackgroundKind get appBackgroundKind {
    final AppSettingsEntity? s = _isar.appSettingsEntitys.getByRowKeySync(
      kSingletonSettings,
    );
    return AppBackgroundKindStorage.fromRaw(s?.appBackgroundKind);
  }

  String? get appBackgroundPresetId {
    final AppSettingsEntity? s = _isar.appSettingsEntitys.getByRowKeySync(
      kSingletonSettings,
    );
    final String? raw = s?.appBackgroundPresetId;
    if (raw == null || raw.isEmpty) {
      return null;
    }
    return raw;
  }

  String? get appBackgroundImageFileName {
    final AppSettingsEntity? s = _isar.appSettingsEntitys.getByRowKeySync(
      kSingletonSettings,
    );
    final String? raw = s?.appBackgroundImageFileName;
    if (raw == null || raw.isEmpty) {
      return null;
    }
    return raw;
  }

  bool get wallpaperActive {
    final AppSettingsEntity? s = _isar.appSettingsEntitys.getByRowKeySync(
      kSingletonSettings,
    );
    final AppBackgroundKind kind = AppBackgroundKindStorage.fromRaw(
      s?.appBackgroundKind,
    );
    switch (kind) {
      case AppBackgroundKind.none:
        return false;
      case AppBackgroundKind.image:
        final File? f = _imageFileOrNull(s?.appBackgroundImageFileName);
        return f != null && f.existsSync();
      case AppBackgroundKind.gradient:
        final String id = AppBackgroundPresets.resolveStaticPresetId(
          s?.appBackgroundPresetId,
        );
        return AppBackgroundPresets.staticGradient(id) != null;
      case AppBackgroundKind.gradientAnimated:
        final String id = AppBackgroundPresets.resolveAnimatedPresetId(
          s?.appBackgroundPresetId,
        );
        return AppBackgroundPresets.animatedSpec(id) != null;
    }
  }

  File? backgroundImageFileIfExists() {
    final AppSettingsEntity? s = _isar.appSettingsEntitys.getByRowKeySync(
      kSingletonSettings,
    );
    return _imageFileIfExists(s?.appBackgroundImageFileName);
  }

  File? _imageFileOrNull(String? fileName) {
    if (fileName == null || fileName.isEmpty) {
      return null;
    }
    return File(p.join(_backgroundsDirectoryPath, fileName));
  }

  File? _imageFileIfExists(String? fileName) {
    final File? f = _imageFileOrNull(fileName);
    if (f == null || !f.existsSync()) {
      return null;
    }
    return f;
  }

  Future<void> setAppBackgroundNone() async {
    await _isar.writeTxn(() async {
      final AppSettingsEntity? row = await _isar.appSettingsEntitys
          .filter()
          .rowKeyEqualTo(kSingletonSettings)
          .findFirst();
      if (row == null) {
        return;
      }
      row.appBackgroundKind = AppBackgroundKindStorage.none;
      row.appBackgroundPresetId = null;
      row.appBackgroundImageFileName = null;
      await _isar.appSettingsEntitys.put(row);
    });
    notifyListeners();
  }

  Future<void> setAppBackgroundGradient(String presetId) async {
    final String id =
        AppBackgroundPresets.staticGradient(presetId) != null
            ? presetId
            : AppBackgroundPresets.defaultStaticPresetId();
    await _isar.writeTxn(() async {
      final AppSettingsEntity? row = await _isar.appSettingsEntitys
          .filter()
          .rowKeyEqualTo(kSingletonSettings)
          .findFirst();
      if (row == null) {
        return;
      }
      row.appBackgroundKind = AppBackgroundKindStorage.gradient;
      row.appBackgroundPresetId = id;
      row.appBackgroundImageFileName = null;
      await _isar.appSettingsEntitys.put(row);
    });
    notifyListeners();
  }

  Future<void> setAppBackgroundAnimated(String presetId) async {
    final String id =
        AppBackgroundPresets.animatedSpec(presetId) != null
            ? presetId
            : AppBackgroundPresets.defaultAnimatedPresetId();
    await _isar.writeTxn(() async {
      final AppSettingsEntity? row = await _isar.appSettingsEntitys
          .filter()
          .rowKeyEqualTo(kSingletonSettings)
          .findFirst();
      if (row == null) {
        return;
      }
      row.appBackgroundKind = AppBackgroundKindStorage.gradientAnimated;
      row.appBackgroundPresetId = id;
      row.appBackgroundImageFileName = null;
      await _isar.appSettingsEntitys.put(row);
    });
    notifyListeners();
  }

  Future<void> clearCustomBackgroundImage() async {
    final AppSettingsEntity? s = _isar.appSettingsEntitys.getByRowKeySync(
      kSingletonSettings,
    );
    final File? old = _imageFileOrNull(s?.appBackgroundImageFileName);
    await _isar.writeTxn(() async {
      final AppSettingsEntity? row = await _isar.appSettingsEntitys
          .filter()
          .rowKeyEqualTo(kSingletonSettings)
          .findFirst();
      if (row == null) {
        return;
      }
      row.appBackgroundImageFileName = null;
      if (row.appBackgroundKind == AppBackgroundKindStorage.image) {
        row.appBackgroundKind = AppBackgroundKindStorage.none;
      }
      await _isar.appSettingsEntitys.put(row);
    });
    if (old != null && old.existsSync()) {
      try {
        await old.delete();
      } catch (_) {}
    }
    notifyListeners();
  }

  Future<BackgroundImageImportResult> importBackgroundImage() async {
    final FilePickerResult? pick = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: false,
    );
    if (pick == null || pick.files.isEmpty) {
      return BackgroundImageImportResult.cancelled;
    }
    final String? srcPath = pick.files.single.path;
    if (srcPath == null) {
      return BackgroundImageImportResult.failed;
    }
    final String ext = p.extension(srcPath).toLowerCase();
    const Set<String> allowed = <String>{
      '.jpg',
      '.jpeg',
      '.png',
      '.webp',
      '.gif',
    };
    if (!allowed.contains(ext)) {
      return BackgroundImageImportResult.failed;
    }
    final Directory dir = Directory(_backgroundsDirectoryPath);
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    final String newName = 'bg_${DateTime.now().microsecondsSinceEpoch}$ext';
    final File dest = File(p.join(_backgroundsDirectoryPath, newName));
    try {
      await File(srcPath).copy(dest.path);
    } catch (_) {
      return BackgroundImageImportResult.failed;
    }
    final AppSettingsEntity? s = _isar.appSettingsEntitys.getByRowKeySync(
      kSingletonSettings,
    );
    final File? previous = _imageFileOrNull(s?.appBackgroundImageFileName);
    await _isar.writeTxn(() async {
      final AppSettingsEntity? row = await _isar.appSettingsEntitys
          .filter()
          .rowKeyEqualTo(kSingletonSettings)
          .findFirst();
      if (row == null) {
        return;
      }
      row.appBackgroundKind = AppBackgroundKindStorage.image;
      row.appBackgroundImageFileName = newName;
      row.appBackgroundPresetId = null;
      await _isar.appSettingsEntitys.put(row);
    });
    if (previous != null &&
        previous.path != dest.path &&
        previous.existsSync()) {
      try {
        await previous.delete();
      } catch (_) {}
    }
    notifyListeners();
    return BackgroundImageImportResult.success;
  }

  Future<void> _repairInvalidBackgroundIfNeeded() async {
    final AppSettingsEntity? row = _isar.appSettingsEntitys.getByRowKeySync(
      kSingletonSettings,
    );
    if (row == null) {
      return;
    }
    final AppBackgroundKind kind = AppBackgroundKindStorage.fromRaw(
      row.appBackgroundKind,
    );
    bool changed = false;
    if (kind == AppBackgroundKind.image) {
      final File? f = _imageFileOrNull(row.appBackgroundImageFileName);
      if (f == null || !f.existsSync()) {
        await _isar.writeTxn(() async {
          final AppSettingsEntity? r = await _isar.appSettingsEntitys
              .filter()
              .rowKeyEqualTo(kSingletonSettings)
              .findFirst();
          if (r == null) {
            return;
          }
          r.appBackgroundKind = AppBackgroundKindStorage.none;
          r.appBackgroundImageFileName = null;
          await _isar.appSettingsEntitys.put(r);
        });
        changed = true;
      }
    }
    if (changed) {
      notifyListeners();
    }
  }

  void _hydrateFromIsar() {
    final AppSettingsEntity? s = _isar.appSettingsEntitys.getByRowKeySync(
      kSingletonSettings,
    );
    if (s == null) {
      return;
    }
    _appearance = AppAppearance.fromStorage(s.themeMode);
    _locale = SettingsController._localeFromStorage(s.languageCode);
  }

  static Locale? _localeFromStorage(String raw) {
    return switch (raw) {
      'en' => const Locale('en'),
      'fr' => const Locale('fr'),
      _ => null,
    };
  }

  Future<void> setAppearance(AppAppearance value) async {
    _appearance = value;
    await _isar.writeTxn(() async {
      final AppSettingsEntity? row = await _isar.appSettingsEntitys
          .filter()
          .rowKeyEqualTo(kSingletonSettings)
          .findFirst();
      if (row == null) {
        return;
      }
      row.themeMode = value.toStorage();
      await _isar.appSettingsEntitys.put(row);
    });
    notifyListeners();
  }

  Future<void> setLanguageCode(String code) async {
    if (code == 'system') {
      _locale = null;
    } else {
      _locale = Locale(code);
    }
    await _isar.writeTxn(() async {
      final AppSettingsEntity? row = await _isar.appSettingsEntitys
          .filter()
          .rowKeyEqualTo(kSingletonSettings)
          .findFirst();
      if (row == null) {
        return;
      }
      row.languageCode = code;
      await _isar.appSettingsEntitys.put(row);
    });
    notifyListeners();
  }

  Future<void> setSwipeStartPaneAction(String value) async {
    await _isar.writeTxn(() async {
      final AppSettingsEntity? row = await _isar.appSettingsEntitys
          .filter()
          .rowKeyEqualTo(kSingletonSettings)
          .findFirst();
      if (row == null) {
        return;
      }
      row.swipeStartPane = value;
      await _isar.appSettingsEntitys.put(row);
    });
    notifyListeners();
  }

  Future<void> setSwipeEndPaneAction(String value) async {
    await _isar.writeTxn(() async {
      final AppSettingsEntity? row = await _isar.appSettingsEntitys
          .filter()
          .rowKeyEqualTo(kSingletonSettings)
          .findFirst();
      if (row == null) {
        return;
      }
      row.swipeEndPane = value;
      await _isar.appSettingsEntitys.put(row);
    });
    notifyListeners();
  }

  Future<void> setWaitingFollowUpDays(int value) async {
    final int clamped = value < 3 ? 3 : (value > 30 ? 30 : value);
    await _isar.writeTxn(() async {
      final AppSettingsEntity? row = await _isar.appSettingsEntitys
          .filter()
          .rowKeyEqualTo(kSingletonSettings)
          .findFirst();
      if (row == null) {
        return;
      }
      row.waitingFollowUpDays = clamped;
      await _isar.appSettingsEntitys.put(row);
    });
    notifyListeners();
    final Future<void> Function()? hook = _onWaitingFollowUpThresholdChanged;
    if (hook != null) {
      await hook();
    }
  }
}
