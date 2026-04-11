import 'package:flutter_test/flutter_test.dart';

import 'package:job_application_tracker/core/applications/job_applications_csv_import.dart';
import 'package:job_application_tracker/core/models/job_application_status.dart';

void main() {
  test('parseJobApplicationsCsv maps headers and rows', () {
    const csv =
        'job_link,title,company,date,status\n'
        'https://jobs.example/1,Engineer,Acme,2024-06-01,submitted\n'
        'https://jobs.example/2,,Beta,2024-06-02,';
    final r = parseJobApplicationsCsv(csv);
    expect(r.errorMessages, isEmpty);
    expect(r.skippedCount, 0);
    expect(r.applications.length, 2);
    expect(r.applications[0].postingUrl, 'https://jobs.example/1');
    expect(r.applications[0].jobTitle, 'Engineer');
    expect(r.applications[0].companyName, 'Acme');
    expect(r.applications[0].status, JobApplicationStatus.submitted);
    expect(r.applications[1].jobTitle, isEmpty);
    expect(r.applications[1].companyName, 'Beta');
  });

  test('parseJobApplicationsCsv accepts semicolon single-line header row', () {
    const csv = 'URL;Title;Company;Date\nhttps://x.test/a;Dev;Co;2024-01-05';
    final r = parseJobApplicationsCsv(csv);
    expect(r.applications.length, 1);
    expect(r.applications[0].postingUrl, 'https://x.test/a');
    expect(r.applications[0].jobTitle, 'Dev');
  });

  test(
    'parseJobApplicationsCsv returns missing_headers without url column',
    () {
      const csv = 'title,company\nDev,Acme';
      final r = parseJobApplicationsCsv(csv);
      expect(r.applications, isEmpty);
      expect(r.errorMessages, contains('missing_headers'));
    },
  );

  test('parseJobApplicationsCsv skips row with bad date when date present', () {
    const csv = 'link,date\nhttps://a.test/b,not-a-date';
    final r = parseJobApplicationsCsv(csv);
    expect(r.applications, isEmpty);
    expect(r.skippedCount, 1);
  });
}
