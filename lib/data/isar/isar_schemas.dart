import 'package:isar/isar.dart';

part 'isar_schemas.g.dart';

const String kSingletonSettings = 'app_settings';
const String kSingletonProfile = 'user_profile';
const String kSingletonNotificationState = 'notification_state';
const String kSingletonMeta = 'app_meta';

@collection
class JobApplicationEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String applicationId;

  late String postingUrl;

  late String jobTitle;

  late String companyName;

  late DateTime submittedOn;

  late String statusName;

  late bool isArchived;

  String? archiveGroupKey;

  String? archiveGroupLabel;
}

@collection
class AppSettingsEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String rowKey;

  late String themeMode;

  late String languageCode;

  late String swipeStartPane;

  late String swipeEndPane;

  late int waitingFollowUpDays;

  String? appBackgroundKind;

  String? appBackgroundImageFileName;

  String? appBackgroundPresetId;
}

@collection
class UserProfileEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String rowKey;

  late String profileJson;
}

@collection
class NotificationStateEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String rowKey;

  List<int> draftTrackedNotificationIds = <int>[];

  List<int> waitingTrackedNotificationIds = <int>[];
}

@collection
class AppMetaEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String rowKey;

  bool prefsMigrationV1Complete = false;
}
