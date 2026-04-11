import 'package:job_application_tracker/core/models/job_application.dart';
import 'package:job_application_tracker/core/models/job_application_status_parse.dart';
import 'package:job_application_tracker/data/isar/isar_schemas.dart';

JobApplicationEntity jobApplicationToEntity(JobApplication a) {
  return JobApplicationEntity()
    ..applicationId = a.id
    ..postingUrl = a.postingUrl
    ..jobTitle = a.jobTitle
    ..companyName = a.companyName
    ..submittedOn = JobApplication.dateOnly(a.submittedOn)
    ..statusName = a.status.name
    ..isArchived = a.isArchived
    ..archiveGroupKey = a.archiveGroupKey
    ..archiveGroupLabel = a.archiveGroupLabel;
}

JobApplication jobApplicationFromEntity(JobApplicationEntity e) {
  return JobApplication(
    id: e.applicationId,
    postingUrl: e.postingUrl,
    jobTitle: e.jobTitle,
    companyName: e.companyName,
    submittedOn: JobApplication.dateOnly(e.submittedOn),
    status: parseStoredJobApplicationStatus(e.statusName),
    isArchived: e.isArchived,
    archiveGroupKey: e.archiveGroupKey,
    archiveGroupLabel: e.archiveGroupLabel,
  );
}
