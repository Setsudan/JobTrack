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
}
