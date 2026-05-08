import 'package:flutter_test/flutter_test.dart';

import 'package:job_application_tracker/core/applications/applications_controller.dart';
import 'package:job_application_tracker/core/models/job_application.dart';
import 'package:job_application_tracker/core/models/job_application_status.dart';

import 'isar_test_support.dart';

void main() {
  test('ApplicationsController persists one row to Isar', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final EphemeralIsar h = await openEphemeralJobTrackIsar();
    try {
      final ApplicationsController apps = ApplicationsController(h.isar);
      await apps.init();
      await apps.add(
        JobApplication(
          id: 'x1',
          postingUrl: 'https://example.com/x',
          jobTitle: 'T',
          companyName: 'C',
          submittedOn: DateTime(2025, 6, 1),
          status: JobApplicationStatus.draft,
        ),
      );
      expect(apps.applications.length, 1);
    } finally {
      await closeEphemeralIsar(h.isar, h.dir);
    }
  });

  test('archiveAllActiveExcept sets archived rows to closed status', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final EphemeralIsar h = await openEphemeralJobTrackIsar();
    try {
      final ApplicationsController apps = ApplicationsController(h.isar);
      await apps.init();
      await apps.add(
        JobApplication(
          id: 'keep',
          postingUrl: 'https://example.com/a',
          jobTitle: 'A',
          companyName: 'Ca',
          submittedOn: DateTime(2025, 1, 1),
          status: JobApplicationStatus.submitted,
        ),
      );
      await apps.add(
        JobApplication(
          id: 'arch',
          postingUrl: 'https://example.com/b',
          jobTitle: 'B',
          companyName: 'Cb',
          submittedOn: DateTime(2025, 1, 2),
          status: JobApplicationStatus.interviewScheduled,
        ),
      );
      await apps.archiveAllActiveExcept(
        exceptId: 'keep',
        at: DateTime(2025, 6, 15),
        groupLabel: 'Test bundle',
      );
      final JobApplication keep = apps.byId('keep')!;
      final JobApplication arch = apps.byId('arch')!;
      expect(keep.isArchived, false);
      expect(keep.status, JobApplicationStatus.submitted);
      expect(arch.isArchived, true);
      expect(arch.status, JobApplicationStatus.closedNotSelected);
    } finally {
      await closeEphemeralIsar(h.isar, h.dir);
    }
  });
}
