import 'package:flutter_test/flutter_test.dart';

import 'package:job_application_tracker/core/applications/application_archive_label.dart';

void main() {
  test('modeDisplayJobTitle picks most frequent normalized title', () {
    expect(
      modeDisplayJobTitle(<String>[
        'Backend engineer',
        'backend engineer',
        'backend engineer',
        'Designer',
      ]),
      'Backend engineer',
    );
  });

  test('archiveGroupKeyFor includes year and half', () {
    final k = archiveGroupKeyFor(
      at: DateTime(2026, 3, 1),
      displayJobTitle: 'Engineer',
    );
    expect(k, '2026-H1|engineer');
  });
}
