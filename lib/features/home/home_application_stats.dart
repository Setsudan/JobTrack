import 'package:job_application_tracker/core/applications/applications_controller.dart';
import 'package:job_application_tracker/core/models/job_application.dart';
import 'package:job_application_tracker/core/models/job_application_status.dart';

class HomeApplicationStats {
  const HomeApplicationStats({
    required this.activeCount,
    required this.waitingOnEmployerCount,
    required this.interviewScheduledCount,
    required this.archivedCount,
  });

  final int activeCount;
  final int waitingOnEmployerCount;
  final int interviewScheduledCount;
  final int archivedCount;

  int get _totalTracked => activeCount + archivedCount;

  double get activeShareOfTracked =>
      _totalTracked == 0 ? 0 : activeCount / _totalTracked;

  double get waitingShareOfActive =>
      activeCount == 0 ? 0 : waitingOnEmployerCount / activeCount;

  double get interviewShareOfActive =>
      activeCount == 0 ? 0 : interviewScheduledCount / activeCount;

  double get archivedShareOfTracked =>
      _totalTracked == 0 ? 0 : archivedCount / _totalTracked;
}

HomeApplicationStats computeHomeApplicationStats(ApplicationsController apps) {
  var activeCount = 0;
  var archivedCount = 0;
  var waiting = 0;
  var interviews = 0;
  for (final JobApplication a in apps.applications) {
    if (a.isArchived) {
      archivedCount++;
      continue;
    }
    activeCount++;
    switch (a.status) {
      case JobApplicationStatus.submitted:
      case JobApplicationStatus.noResponseYet:
        waiting++;
      case JobApplicationStatus.interviewScheduled:
        interviews++;
      case JobApplicationStatus.draft:
      case JobApplicationStatus.decisionPending:
      case JobApplicationStatus.closedNotSelected:
      case JobApplicationStatus.offerAccepted:
        break;
    }
  }
  return HomeApplicationStats(
    activeCount: activeCount,
    waitingOnEmployerCount: waiting,
    interviewScheduledCount: interviews,
    archivedCount: archivedCount,
  );
}
