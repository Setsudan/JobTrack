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
    expect(r.applications[1].status, JobApplicationStatus.draft);
    expect(r.hadSubmittedOnFromCsv, <bool>[true, true]);
  });

  test('parseJobApplicationsCsv accepts semicolon single-line header row', () {
    const csv = 'URL;Title;Company;Date\nhttps://x.test/a;Dev;Co;2024-01-05';
    final r = parseJobApplicationsCsv(csv);
    expect(r.applications.length, 1);
    expect(r.applications[0].postingUrl, 'https://x.test/a');
    expect(r.applications[0].jobTitle, 'Dev');
    expect(r.hadSubmittedOnFromCsv, <bool>[true]);
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

  test(
    'parseJobApplicationsCsv keeps row when date unparsable and records bad_date',
    () {
      const csv = 'link,date\nhttps://a.test/b,not-a-date';
      final r = parseJobApplicationsCsv(csv);
      expect(r.applications.length, 1);
      expect(r.applications[0].postingUrl, 'https://a.test/b');
      expect(r.skippedCount, 0);
      expect(r.errorMessages, contains('bad_date'));
      expect(r.hadSubmittedOnFromCsv, <bool>[false]);
    },
  );

  test('parseJobApplicationsCsv infers URL column without known headers', () {
    const csv =
        'Role,Firm,Apply\n'
        'Engineer,Acme,https://jobs.example/1\n'
        'PM,Beta,https://jobs.example/2';
    final r = parseJobApplicationsCsv(csv);
    expect(r.errorMessages.where((e) => e == 'missing_headers'), isEmpty);
    expect(r.applications.length, 2);
    expect(r.applications[0].postingUrl, 'https://jobs.example/1');
    expect(r.applications[0].jobTitle, 'Engineer');
    expect(r.applications[0].companyName, 'Acme');
    expect(r.hadSubmittedOnFromCsv, <bool>[false, false]);
  });

  test('parseJobApplicationsCsv handles bare URL list without header row', () {
    const csv = 'https://one.test/a\nhttps://two.test/b';
    final r = parseJobApplicationsCsv(csv);
    expect(r.applications.length, 2);
    expect(r.applications[0].postingUrl, 'https://one.test/a');
    expect(r.applications[1].postingUrl, 'https://two.test/b');
    expect(r.hadSubmittedOnFromCsv, <bool>[false, false]);
  });

  test('parseJobApplicationsCsv accepts tab delimiter', () {
    const csv = 'link\ttitle\nhttps://x.test/a\tDev';
    final r = parseJobApplicationsCsv(csv);
    expect(r.applications.length, 1);
    expect(r.applications[0].postingUrl, 'https://x.test/a');
    expect(r.applications[0].jobTitle, 'Dev');
    expect(r.hadSubmittedOnFromCsv, <bool>[false]);
  });

  test('parseJobApplicationsCsv strips UTF-8 BOM', () {
    const csv = '\uFEFFlink,title\nhttps://x.test/a,Dev';
    final r = parseJobApplicationsCsv(csv);
    expect(r.applications.length, 1);
    expect(r.applications[0].jobTitle, 'Dev');
  });

  test('parseJobApplicationsCsv finds URL inside a wider cell', () {
    const csv = 'Notes\nApply at https://x.test/job?id=1 (soon)';
    final r = parseJobApplicationsCsv(csv);
    expect(r.applications.length, 1);
    expect(r.applications[0].postingUrl, 'https://x.test/job?id=1');
  });

  test('parseJobApplicationsCsv handles quoted field with newline', () {
    const csv =
        'link,title\n'
        '"https://x.test/a\nline2",Dev';
    final r = parseJobApplicationsCsv(csv);
    expect(r.applications.length, 1);
    expect(r.applications[0].postingUrl, 'https://x.test/a');
    expect(r.applications[0].jobTitle, 'Dev');
  });
}
