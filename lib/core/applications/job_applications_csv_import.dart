import 'package:csv/csv.dart';

import 'package:job_application_tracker/core/applications/application_id.dart';
import 'package:job_application_tracker/core/models/job_application.dart';
import 'package:job_application_tracker/core/models/job_application_status.dart';
import 'package:job_application_tracker/core/models/job_application_status_parse.dart';

class CsvImportResult {
  CsvImportResult({
    required this.applications,
    required this.skippedCount,
    required this.errorMessages,
  });

  final List<JobApplication> applications;
  final int skippedCount;
  final List<String> errorMessages;
}

String _normCell(Object? cell) {
  if (cell == null) {
    return '';
  }
  return cell.toString().trim();
}

String _headerKey(String raw) {
  return raw.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '_');
}

bool _headerMatches(String key, Set<String> aliases) {
  return aliases.contains(key);
}

int? _findUrlColumnIndex(List<String> headerKeys) {
  const aliases = <String>{
    'postingurl',
    'posting_url',
    'job_link',
    'joblink',
    'url',
    'link',
    'job_url',
    'joburl',
    'application_url',
    'lien',
    'lien_offre',
  };
  for (var i = 0; i < headerKeys.length; i++) {
    if (_headerMatches(headerKeys[i], aliases)) {
      return i;
    }
  }
  return null;
}

int? _findColumn(List<String> headerKeys, Set<String> aliases) {
  for (var i = 0; i < headerKeys.length; i++) {
    if (_headerMatches(headerKeys[i], aliases)) {
      return i;
    }
  }
  return null;
}

DateTime? _parseDateCell(String raw) {
  final t = raw.trim();
  if (t.isEmpty) {
    return null;
  }
  final iso = RegExp(r'^(\d{4})-(\d{2})-(\d{2})');
  final m = iso.firstMatch(t);
  if (m != null) {
    final y = int.tryParse(m.group(1)!);
    final mo = int.tryParse(m.group(2)!);
    final d = int.tryParse(m.group(3)!);
    if (y != null && mo != null && d != null) {
      return JobApplication.dateOnly(DateTime(y, mo, d));
    }
  }
  return null;
}

JobApplicationStatus _parseStatusCell(String raw) {
  final t = raw.trim();
  if (t.isEmpty) {
    return JobApplicationStatus.submitted;
  }
  final lower = t.toLowerCase();
  switch (lower) {
    case 'draft':
    case 'saved for later':
    case 'brouillon':
      return JobApplicationStatus.draft;
    case 'applied':
    case 'submitted':
    case 'postulé':
    case 'postule':
      return JobApplicationStatus.submitted;
    case 'no response':
    case 'no reply':
    case 'waiting':
    case 'pas de réponse':
    case 'pas_de_reponse':
      return JobApplicationStatus.noResponseYet;
    case 'interview':
    case 'entretien':
      return JobApplicationStatus.interviewScheduled;
    case 'decision':
    case 'pending decision':
      return JobApplicationStatus.decisionPending;
    case 'rejected':
    case 'closed':
    case 'not selected':
    case 'refus':
    case 'non retenu':
      return JobApplicationStatus.closedNotSelected;
    case 'offer':
    case 'accepted':
    case 'offre':
      return JobApplicationStatus.offerAccepted;
    default:
      return parseStoredJobApplicationStatus(lower.replaceAll(' ', ''));
  }
}

List<List<dynamic>> _rowsFromDelimitedLines(
  String normalized, {
  required String fieldDelimiter,
}) {
  final lines = normalized
      .split('\n')
      .map((String s) => s.trim())
      .where((String s) => s.isNotEmpty)
      .toList();
  final conv = CsvToListConverter(fieldDelimiter: fieldDelimiter);
  final rows = <List<dynamic>>[];
  for (final String line in lines) {
    final parsed = conv.convert(line);
    if (parsed.isNotEmpty) {
      rows.add(parsed.first);
    }
  }
  return rows;
}

CsvImportResult parseJobApplicationsCsv(String text) {
  final normalized = text.replaceAll('\r\n', '\n').trim();
  if (normalized.isEmpty) {
    return CsvImportResult(
      applications: <JobApplication>[],
      skippedCount: 0,
      errorMessages: <String>[],
    );
  }
  List<List<dynamic>> rows;
  try {
    final firstLine = normalized.split('\n').firstWhere(
      (String s) => s.trim().isNotEmpty,
      orElse: () => '',
    );
    final delim =
        firstLine.contains(';') && !firstLine.contains(',') ? ';' : ',';
    rows = _rowsFromDelimitedLines(normalized, fieldDelimiter: delim);
  } catch (_) {
    return CsvImportResult(
      applications: <JobApplication>[],
      skippedCount: 0,
      errorMessages: <String>['parse_error'],
    );
  }
  if (rows.isEmpty) {
    return CsvImportResult(
      applications: <JobApplication>[],
      skippedCount: 0,
      errorMessages: <String>[],
    );
  }

  while (rows.isNotEmpty &&
      rows.first.every((dynamic c) => _normCell(c).isEmpty)) {
    rows = rows.sublist(1);
  }
  if (rows.isEmpty) {
    return CsvImportResult(
      applications: <JobApplication>[],
      skippedCount: 0,
      errorMessages: <String>[],
    );
  }

  final headerRow = rows.first.map(_normCell).toList();
  if (headerRow.isEmpty) {
    return CsvImportResult(
      applications: <JobApplication>[],
      skippedCount: 0,
      errorMessages: <String>['missing_headers'],
    );
  }
  final headerKeys = headerRow.map(_headerKey).toList();
  final urlIx = _findUrlColumnIndex(headerKeys);
  if (urlIx == null) {
    return CsvImportResult(
      applications: <JobApplication>[],
      skippedCount: 0,
      errorMessages: <String>['missing_headers'],
    );
  }

  final titleIx = _findColumn(headerKeys, <String>{
    'title',
    'role',
    'job_title',
    'position',
    'titre',
    'poste',
  });
  final companyIx = _findColumn(headerKeys, <String>{
    'company',
    'employer',
    'company_name',
    'entreprise',
    'societe',
    'société',
  });
  final dateIx = _findColumn(headerKeys, <String>{
    'date',
    'submitted',
    'applied',
    'submitted_on',
    'applied_on',
    'date_posted',
    'date_applied',
  });
  final statusIx = _findColumn(headerKeys, <String>{
    'status',
    'state',
    'statut',
  });

  final out = <JobApplication>[];
  var skipped = 0;
  final errs = <String>[];

  for (var r = 1; r < rows.length; r++) {
    final row = rows[r];
    if (row.isEmpty) {
      continue;
    }
    String cellAt(int? ix) {
      if (ix == null || ix >= row.length) {
        return '';
      }
      return _normCell(row[ix]);
    }

    final url = cellAt(urlIx);
    if (url.isEmpty) {
      skipped++;
      continue;
    }
    if (!url.contains('://') && !url.startsWith('www.')) {
      skipped++;
      errs.add('bad_url');
      continue;
    }
    final postingUrl =
        url.startsWith('www.') ? 'https://$url' : url;
    final title = titleIx != null ? cellAt(titleIx) : '';
    final company = companyIx != null ? cellAt(companyIx) : '';
    final dateRaw = dateIx != null ? cellAt(dateIx) : '';
    final parsedDate = dateRaw.isNotEmpty ? _parseDateCell(dateRaw) : null;
    if (dateRaw.isNotEmpty && parsedDate == null) {
      skipped++;
      errs.add('bad_date');
      continue;
    }
    final submittedOn =
        parsedDate ?? JobApplication.dateOnly(DateTime.now());
    final statusRaw = statusIx != null ? cellAt(statusIx) : '';
    final status =
        statusRaw.isNotEmpty
            ? _parseStatusCell(statusRaw)
            : JobApplicationStatus.submitted;

    out.add(
      JobApplication(
        id: newJobApplicationId(),
        postingUrl: postingUrl,
        jobTitle: title,
        companyName: company,
        submittedOn: submittedOn,
        status: status,
      ),
    );
  }

  return CsvImportResult(
    applications: out,
    skippedCount: skipped,
    errorMessages: errs,
  );
}
