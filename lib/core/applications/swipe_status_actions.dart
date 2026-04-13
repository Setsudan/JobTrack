import 'package:job_application_tracker/core/models/job_application_status.dart';

/// Sentinel stored in preferences for the swipe shortcut that advances the pipeline.
const String swipeActionAdvanceStorageValue = 'advance';

JobApplicationStatus advanceOneStage(JobApplicationStatus current) {
  switch (current) {
    case JobApplicationStatus.draft:
      return JobApplicationStatus.submitted;
    case JobApplicationStatus.submitted:
      return JobApplicationStatus.noResponseYet;
    case JobApplicationStatus.noResponseYet:
      return JobApplicationStatus.interviewScheduled;
    case JobApplicationStatus.interviewScheduled:
      return JobApplicationStatus.decisionPending;
    case JobApplicationStatus.decisionPending:
      return JobApplicationStatus.decisionPending;
    case JobApplicationStatus.closedNotSelected:
    case JobApplicationStatus.offerAccepted:
      return current;
  }
}

/// Swipe that reveals the **start** action pane (e.g. drag right in LTR).
JobApplicationStatus resolveStartPaneSwipeTarget(
  String raw,
  JobApplicationStatus current,
) {
  final trimmed = raw.trim();
  if (trimmed.isEmpty || trimmed == swipeActionAdvanceStorageValue) {
    return advanceOneStage(current);
  }
  try {
    return JobApplicationStatus.values.byName(trimmed);
  } catch (_) {
    return advanceOneStage(current);
  }
}

/// Swipe that reveals the **end** action pane (e.g. drag left in LTR).
JobApplicationStatus resolveEndPaneSwipeTarget(
  String raw,
  JobApplicationStatus current,
) {
  final trimmed = raw.trim();
  if (trimmed.isEmpty || trimmed == swipeActionAdvanceStorageValue) {
    return JobApplicationStatus.closedNotSelected;
  }
  try {
    return JobApplicationStatus.values.byName(trimmed);
  } catch (_) {
    return JobApplicationStatus.closedNotSelected;
  }
}

bool startSwipeWouldChangeStatus(
  String raw,
  JobApplicationStatus current,
) {
  return resolveStartPaneSwipeTarget(raw, current) != current;
}

bool endSwipeWouldChangeStatus(
  String raw,
  JobApplicationStatus current,
) {
  return resolveEndPaneSwipeTarget(raw, current) != current;
}
