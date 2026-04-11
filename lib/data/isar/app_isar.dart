import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:job_application_tracker/core/applications/swipe_status_actions.dart';
import 'package:job_application_tracker/data/isar/isar_schemas.dart';

List<CollectionSchema<dynamic>> get jobTrackIsarSchemas =>
    <CollectionSchema<dynamic>>[
      JobApplicationEntitySchema,
      AppSettingsEntitySchema,
      UserProfileEntitySchema,
      NotificationStateEntitySchema,
      AppMetaEntitySchema,
    ];

Future<Isar> openJobTrackIsarInDirectory(
  String directoryPath, {
  String name = 'jobtrack',
}) {
  return Isar.open(jobTrackIsarSchemas, directory: directoryPath, name: name);
}

Future<Isar> openJobTrackIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  return openJobTrackIsarInDirectory(dir.path);
}

/// Default singleton rows so controllers can read synchronously after open.
Future<void> ensureIsarSingletonDefaults(Isar isar) async {
  await isar.writeTxn(() async {
    final AppSettingsEntity? s = await isar.appSettingsEntitys
        .filter()
        .rowKeyEqualTo(kSingletonSettings)
        .findFirst();
    if (s == null) {
      await isar.appSettingsEntitys.put(
        AppSettingsEntity()
          ..rowKey = kSingletonSettings
          ..themeMode = 'system'
          ..languageCode = 'system'
          ..swipeStartPane = swipeActionAdvanceStorageValue
          ..swipeEndPane = 'closedNotSelected'
          ..waitingFollowUpDays = 7,
      );
    }
    final UserProfileEntity? p = await isar.userProfileEntitys
        .filter()
        .rowKeyEqualTo(kSingletonProfile)
        .findFirst();
    if (p == null) {
      await isar.userProfileEntitys.put(
        UserProfileEntity()
          ..rowKey = kSingletonProfile
          ..profileJson = '{}',
      );
    }
    final NotificationStateEntity? n = await isar.notificationStateEntitys
        .filter()
        .rowKeyEqualTo(kSingletonNotificationState)
        .findFirst();
    if (n == null) {
      await isar.notificationStateEntitys.put(
        NotificationStateEntity()
          ..rowKey = kSingletonNotificationState
          ..draftTrackedNotificationIds = <int>[]
          ..waitingTrackedNotificationIds = <int>[],
      );
    }
    final AppMetaEntity? m = await isar.appMetaEntitys
        .filter()
        .rowKeyEqualTo(kSingletonMeta)
        .findFirst();
    if (m == null) {
      await isar.appMetaEntitys.put(
        AppMetaEntity()
          ..rowKey = kSingletonMeta
          ..prefsMigrationV1Complete = false,
      );
    }
  });
}
