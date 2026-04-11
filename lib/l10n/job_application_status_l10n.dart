import 'package:job_application_tracker/core/models/job_application_status.dart';
import 'package:job_application_tracker/l10n/app_localizations.dart';

extension JobApplicationStatusL10n on JobApplicationStatus {
  String localize(AppLocalizations l10n) {
    return switch (this) {
      JobApplicationStatus.draft => l10n.jobStatusDraft,
      JobApplicationStatus.submitted => l10n.jobStatusSubmitted,
      JobApplicationStatus.noResponseYet => l10n.jobStatusNoResponseYet,
      JobApplicationStatus.interviewScheduled =>
        l10n.jobStatusInterviewScheduled,
      JobApplicationStatus.decisionPending => l10n.jobStatusDecisionPending,
      JobApplicationStatus.closedNotSelected => l10n.jobStatusClosedNotSelected,
      JobApplicationStatus.offerAccepted => l10n.jobStatusOfferAccepted,
    };
  }
}
