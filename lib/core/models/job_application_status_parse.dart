import 'package:job_application_tracker/core/models/job_application_status.dart';

JobApplicationStatus parseStoredJobApplicationStatus(String? raw) {
  if (raw == null || raw.isEmpty) {
    return JobApplicationStatus.submitted;
  }
  switch (raw) {
    case 'notApplied':
      return JobApplicationStatus.draft;
    case 'applied':
      return JobApplicationStatus.submitted;
    case 'gotResponse':
      return JobApplicationStatus.noResponseYet;
    case 'meetUpPlanned':
      return JobApplicationStatus.interviewScheduled;
    case 'waitingForReply':
      return JobApplicationStatus.decisionPending;
    case 'notTaken':
      return JobApplicationStatus.closedNotSelected;
    case 'gotTheJob':
      return JobApplicationStatus.offerAccepted;
  }
  try {
    return JobApplicationStatus.values.byName(raw);
  } catch (_) {
    return JobApplicationStatus.submitted;
  }
}
