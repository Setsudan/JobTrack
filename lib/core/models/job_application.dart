import 'package:job_application_tracker/core/models/job_application_status.dart';
import 'package:job_application_tracker/core/models/job_application_status_parse.dart';

class JobApplication {
  JobApplication({
    required this.id,
    required this.postingUrl,
    this.jobTitle = '',
    this.companyName = '',
    required this.submittedOn,
    this.status = JobApplicationStatus.submitted,
    this.isArchived = false,
    this.archiveGroupKey,
    this.archiveGroupLabel,
  });

  final String id;
  final String postingUrl;
  String jobTitle;
  String companyName;
  DateTime submittedOn;
  JobApplicationStatus status;
  bool isArchived;
  String? archiveGroupKey;
  String? archiveGroupLabel;

  static DateTime dateOnly(DateTime d) {
    return DateTime(d.year, d.month, d.day);
  }

  JobApplication copyWith({
    String? id,
    String? postingUrl,
    String? jobTitle,
    String? companyName,
    DateTime? submittedOn,
    JobApplicationStatus? status,
    bool? isArchived,
    String? archiveGroupKey,
    String? archiveGroupLabel,
    bool clearArchiveGroupKey = false,
    bool clearArchiveGroupLabel = false,
  }) {
    return JobApplication(
      id: id ?? this.id,
      postingUrl: postingUrl ?? this.postingUrl,
      jobTitle: jobTitle ?? this.jobTitle,
      companyName: companyName ?? this.companyName,
      submittedOn: submittedOn ?? this.submittedOn,
      status: status ?? this.status,
      isArchived: isArchived ?? this.isArchived,
      archiveGroupKey: clearArchiveGroupKey
          ? null
          : (archiveGroupKey ?? this.archiveGroupKey),
      archiveGroupLabel: clearArchiveGroupLabel
          ? null
          : (archiveGroupLabel ?? this.archiveGroupLabel),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'postingUrl': postingUrl,
    'jobTitle': jobTitle,
    'companyName': companyName,
    'submittedOn': _dateToJson(submittedOn),
    'status': status.name,
    'isArchived': isArchived,
    'archiveGroupKey': archiveGroupKey,
    'archiveGroupLabel': archiveGroupLabel,
  };

  static JobApplication fromJson(Map<String, dynamic> json) {
    return JobApplication(
      id: json['id'] as String,
      postingUrl: json['postingUrl'] as String,
      jobTitle: json['jobTitle'] as String? ?? '',
      companyName: json['companyName'] as String? ?? '',
      submittedOn: _dateFromJson(json['submittedOn'] as String),
      status: parseStoredJobApplicationStatus(json['status'] as String?),
      isArchived: json['isArchived'] as bool? ?? false,
      archiveGroupKey: json['archiveGroupKey'] as String?,
      archiveGroupLabel: json['archiveGroupLabel'] as String?,
    );
  }

  static String _dateToJson(DateTime d) {
    final x = dateOnly(d);
    final m = x.month.toString().padLeft(2, '0');
    final day = x.day.toString().padLeft(2, '0');
    return '${x.year}-$m-$day';
  }

  static DateTime _dateFromJson(String s) {
    final parts = s.split('-');
    if (parts.length != 3) {
      return dateOnly(DateTime.now());
    }
    final y = int.tryParse(parts[0]) ?? DateTime.now().year;
    final mo = int.tryParse(parts[1]) ?? 1;
    final d = int.tryParse(parts[2]) ?? 1;
    return dateOnly(DateTime(y, mo, d));
  }
}
