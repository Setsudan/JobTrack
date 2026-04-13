import 'package:flutter_test/flutter_test.dart';

import 'package:job_application_tracker/core/applications/swipe_status_actions.dart';
import 'package:job_application_tracker/core/models/job_application_status.dart';

void main() {
  test('advanceOneStage moves along the pipeline then caps', () {
    expect(
      advanceOneStage(JobApplicationStatus.draft),
      JobApplicationStatus.submitted,
    );
    expect(
      advanceOneStage(JobApplicationStatus.submitted),
      JobApplicationStatus.noResponseYet,
    );
    expect(
      advanceOneStage(JobApplicationStatus.noResponseYet),
      JobApplicationStatus.interviewScheduled,
    );
    expect(
      advanceOneStage(JobApplicationStatus.interviewScheduled),
      JobApplicationStatus.decisionPending,
    );
    expect(
      advanceOneStage(JobApplicationStatus.decisionPending),
      JobApplicationStatus.decisionPending,
    );
    expect(
      advanceOneStage(JobApplicationStatus.closedNotSelected),
      JobApplicationStatus.closedNotSelected,
    );
  });

  test('resolveStartPaneSwipeTarget defaults to advance', () {
    expect(
      resolveStartPaneSwipeTarget('', JobApplicationStatus.draft),
      JobApplicationStatus.submitted,
    );
    expect(
      resolveStartPaneSwipeTarget(
        swipeActionAdvanceStorageValue,
        JobApplicationStatus.draft,
      ),
      JobApplicationStatus.submitted,
    );
    expect(
      resolveStartPaneSwipeTarget(
        'interviewScheduled',
        JobApplicationStatus.submitted,
      ),
      JobApplicationStatus.interviewScheduled,
    );
  });

  test('resolveEndPaneSwipeTarget defaults reject when advance chosen', () {
    expect(
      resolveEndPaneSwipeTarget(
        swipeActionAdvanceStorageValue,
        JobApplicationStatus.submitted,
      ),
      JobApplicationStatus.closedNotSelected,
    );
    expect(
      resolveEndPaneSwipeTarget(
        'offerAccepted',
        JobApplicationStatus.submitted,
      ),
      JobApplicationStatus.offerAccepted,
    );
  });

  test('startSwipeWouldChangeStatus is false when advance is capped', () {
    expect(
      startSwipeWouldChangeStatus(
        swipeActionAdvanceStorageValue,
        JobApplicationStatus.decisionPending,
      ),
      isFalse,
    );
    expect(
      startSwipeWouldChangeStatus(
        swipeActionAdvanceStorageValue,
        JobApplicationStatus.closedNotSelected,
      ),
      isFalse,
    );
  });

  test('endSwipeWouldChangeStatus is false when already at target', () {
    expect(
      endSwipeWouldChangeStatus(
        swipeActionAdvanceStorageValue,
        JobApplicationStatus.closedNotSelected,
      ),
      isFalse,
    );
    expect(
      endSwipeWouldChangeStatus(
        'submitted',
        JobApplicationStatus.submitted,
      ),
      isFalse,
    );
  });
}
