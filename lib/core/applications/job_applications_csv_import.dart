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
    required this.hadSubmittedOnFromCsv,
  });

  final List<JobApplication> applications;
  final int skippedCount;
  final List<String> errorMessages;

  /// Parallel to [applications]: true when a usable date was read from the CSV
  /// for that row.
  final List<bool> hadSubmittedOnFromCsv;

  bool get hasAnyMissingCsvDate =>
      hadSubmittedOnFromCsv.any((bool had) => !had);
}

final RegExp _urlInText = RegExp(
  r'https?://[^\s,"<>]+|www\.[^\s,"<>]+',
  caseSensitive: false,
);

String _normCell(Object? cell) {
  if (cell == null) {
    return '';
  }
  return cell.toString().trim();
}

String _headerKey(String raw) {
  var s = raw.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '_');
  if (s.isNotEmpty && s.codeUnitAt(0) == 0xFEFF) {
    s = s.substring(1);
  }
  return s;
}

bool _headerMatches(String key, Set<String> aliases) {
  return aliases.contains(key);
}

bool _isUrlLike(String raw) {
  final t = raw.trim();
  if (t.isEmpty) {
    return false;
  }
  return t.startsWith('http://') ||
      t.startsWith('https://') ||
      t.startsWith('www.');
}

String? _firstUrlInText(String raw) {
  final m = _urlInText.firstMatch(raw);
  if (m == null) {
    return null;
  }
  return m.group(0);
}

String? _urlFromCell(String cell) {
  final t = cell.trim();
  if (t.isEmpty) {
    return null;
  }
  if (_isUrlLike(t)) {
    return t;
  }
  return _firstUrlInText(t);
}

String? _firstUrlInRow(List<dynamic> row) {
  for (final Object? cell in row) {
    final u = _urlFromCell(_normCell(cell));
    if (u != null) {
      return u;
    }
  }
  return null;
}

int _maxColumnCount(List<List<dynamic>> rows) {
  var m = 0;
  for (final r in rows) {
    if (r.length > m) {
      m = r.length;
    }
  }
  return m;
}

String _cellAt(List<dynamic> row, int ix) {
  if (ix < 0 || ix >= row.length) {
    return '';
  }
  return _normCell(row[ix]);
}

int? _findUrlColumnIndex(List<String> headerKeys) {
  const aliases = <String>{
    'postingurl',
    'posting_url',
    'posting_link',
    'job_link',
    'joblink',
    'job_url',
    'joburl',
    'application_url',
    'apply_url',
    'listing_url',
    'listingurl',
    'vacancy_url',
    'vacancyurl',
    'position_url',
    'offer_url',
    'offer_link',
    'ad_url',
    'url',
    'link',
    'href',
    'hyperlink',
    'website',
    'source',
    'source_url',
    'lien',
    'lien_offre',
    'lien_annonce',
    'url_de_loffre',
    'url_de_l_annonce',
  };
  for (var i = 0; i < headerKeys.length; i++) {
    if (_headerMatches(headerKeys[i], aliases)) {
      return i;
    }
    final k = headerKeys[i];
    if (k.contains('://') || k.startsWith('www.')) {
      continue;
    }
    if (k.length > 48) {
      continue;
    }
    if (k.contains('email') || k.contains('logo') || k.contains('image')) {
      continue;
    }
    if (k.contains('url') || k.endsWith('_link') || k.endsWith('link')) {
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
  final mIso = iso.firstMatch(t);
  if (mIso != null) {
    final y = int.tryParse(mIso.group(1)!);
    final mo = int.tryParse(mIso.group(2)!);
    final d = int.tryParse(mIso.group(3)!);
    if (y != null && mo != null && d != null) {
      return JobApplication.dateOnly(DateTime(y, mo, d));
    }
  }
  final slash = RegExp(r'^(\d{1,2})[./-](\d{1,2})[./-](\d{4})\b');
  final m = slash.firstMatch(t);
  if (m != null) {
    final a = int.tryParse(m.group(1)!);
    final b = int.tryParse(m.group(2)!);
    final y = int.tryParse(m.group(3)!);
    if (a == null || b == null || y == null || y < 1900 || y > 2100) {
      return null;
    }
    int day;
    int month;
    if (a > 12) {
      day = a;
      month = b;
    } else if (b > 12) {
      month = a;
      day = b;
    } else {
      day = a;
      month = b;
    }
    if (day >= 1 &&
        day <= 31 &&
        month >= 1 &&
        month <= 12 &&
        _isValidYmd(y, month, day)) {
      return JobApplication.dateOnly(DateTime(y, month, day));
    }
  }
  return null;
}

bool _isValidYmd(int y, int month, int day) {
  if (day < 1 || month < 1 || month > 12) {
    return false;
  }
  if (month == 2 && day > 29) {
    return false;
  }
  if (<int>{4, 6, 9, 11}.contains(month) && day > 30) {
    return false;
  }
  if (month == 2 && day == 29) {
    final leap = y % 4 == 0 && (y % 100 != 0 || y % 400 == 0);
    return leap;
  }
  return day <= 31;
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

String _detectDelimiter(String firstLine) {
  final tabs = '\t'.allMatches(firstLine).length;
  final commas = ','.allMatches(firstLine).length;
  final semis = ';'.allMatches(firstLine).length;
  if (tabs > 0 && tabs >= commas) {
    return '\t';
  }
  if (semis > 0 && commas == 0) {
    return ';';
  }
  return ',';
}

List<List<dynamic>> _parseCsvRows(String normalized, String fieldDelimiter) {
  final conv = CsvToListConverter(fieldDelimiter: fieldDelimiter, eol: '\n');
  return conv.convert(normalized);
}

int? _inferUrlColumnIndex(
  List<List<dynamic>> rows, {
  required int startRow,
  required int endRow,
  required int maxCols,
}) {
  if (startRow > endRow || maxCols <= 0) {
    return null;
  }
  final scores = List<int>.filled(maxCols, 0);
  for (var r = startRow; r <= endRow; r++) {
    final row = rows[r];
    for (var c = 0; c < maxCols && c < row.length; c++) {
      if (_urlFromCell(_cellAt(row, c)) != null) {
        scores[c]++;
      }
    }
  }
  var best = 0;
  for (var c = 0; c < maxCols; c++) {
    if (scores[c] > best) {
      best = scores[c];
    }
  }
  if (best <= 0) {
    return null;
  }
  for (var c = 0; c < maxCols; c++) {
    if (scores[c] == best) {
      return c;
    }
  }
  return null;
}

CsvImportResult parseJobApplicationsCsv(String text) {
  var normalized = text.replaceAll('\r\n', '\n').trim();
  if (normalized.isEmpty) {
    return CsvImportResult(
      applications: <JobApplication>[],
      skippedCount: 0,
      errorMessages: <String>[],
      hadSubmittedOnFromCsv: const <bool>[],
    );
  }
  if (normalized.isNotEmpty && normalized.codeUnitAt(0) == 0xFEFF) {
    normalized = normalized.substring(1);
  }
  List<List<dynamic>> rows;
  try {
    final firstLine = normalized.split('\n').firstWhere(
      (String s) => s.trim().isNotEmpty,
      orElse: () => '',
    );
    final delim = _detectDelimiter(firstLine);
    rows = _parseCsvRows(normalized, delim);
  } catch (_) {
    return CsvImportResult(
      applications: <JobApplication>[],
      skippedCount: 0,
      errorMessages: <String>['parse_error'],
      hadSubmittedOnFromCsv: const <bool>[],
    );
  }
  if (rows.isEmpty) {
    return CsvImportResult(
      applications: <JobApplication>[],
      skippedCount: 0,
      errorMessages: <String>[],
      hadSubmittedOnFromCsv: const <bool>[],
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
      hadSubmittedOnFromCsv: const <bool>[],
    );
  }

  final headerRow = rows.first.map(_normCell).toList();
  if (headerRow.isEmpty) {
    return CsvImportResult(
      applications: <JobApplication>[],
      skippedCount: 0,
      errorMessages: <String>['missing_headers'],
      hadSubmittedOnFromCsv: const <bool>[],
    );
  }
  final headerKeys = headerRow.map(_headerKey).toList();
  final maxCols = _maxColumnCount(rows);

  var urlIx = _findUrlColumnIndex(headerKeys);
  var firstDataRow = 1;
  const int scanRowMarker = -1;

  if (urlIx != null) {
    firstDataRow = 1;
  } else if (rows.length > 1) {
    urlIx = _inferUrlColumnIndex(
      rows,
      startRow: 1,
      endRow: rows.length - 1,
      maxCols: maxCols,
    );
    if (urlIx != null) {
      firstDataRow = _urlFromCell(_cellAt(rows.first, urlIx)) != null ? 0 : 1;
    }
  }

  if (urlIx == null) {
    urlIx = _inferUrlColumnIndex(
      rows,
      startRow: 0,
      endRow: rows.length - 1,
      maxCols: maxCols,
    );
    if (urlIx != null) {
      firstDataRow = 0;
    }
  }

  if (urlIx == null) {
    if (_firstUrlInRow(rows.first) != null ||
        (rows.length > 1 && _firstUrlInRow(rows[1]) != null)) {
      urlIx = scanRowMarker;
      firstDataRow = _firstUrlInRow(rows.first) != null ? 0 : 1;
    }
  }

  if (urlIx == null) {
    return CsvImportResult(
      applications: <JobApplication>[],
      skippedCount: 0,
      errorMessages: <String>['missing_headers'],
      hadSubmittedOnFromCsv: const <bool>[],
    );
  }

  final useHeaderRowForFields = firstDataRow >= 1;

  final titleIx = useHeaderRowForFields
      ? _findColumn(headerKeys, <String>{
          'title',
          'role',
          'job_title',
          'position',
          'job',
          'jobname',
          'job_name',
          'opening',
          'requisition',
          'titre',
          'poste',
          'intitule',
          'intitulé',
          'fonction',
        })
      : null;
  final companyIx = useHeaderRowForFields
      ? _findColumn(headerKeys, <String>{
          'company',
          'employer',
          'company_name',
          'organization',
          'org',
          'hiring_company',
          'firm',
          'client',
          'entreprise',
          'societe',
          'société',
          'employeur',
        })
      : null;
  final dateIx = useHeaderRowForFields
      ? _findColumn(headerKeys, <String>{
          'date',
          'submitted',
          'applied',
          'submitted_on',
          'applied_on',
          'date_posted',
          'date_applied',
          'application_date',
          'created',
          'created_at',
        })
      : null;
  final statusIx = useHeaderRowForFields
      ? _findColumn(headerKeys, <String>{
          'status',
          'state',
          'stage',
          'statut',
          'etat',
          'état',
        })
      : null;

  final out = <JobApplication>[];
  final hadDateFromCsv = <bool>[];
  var skipped = 0;
  final errs = <String>[];

  for (var r = firstDataRow; r < rows.length; r++) {
    final row = rows[r];
    if (row.isEmpty) {
      continue;
    }
    String cellAt(int? ix) {
      if (ix == null || ix < 0 || ix >= row.length) {
        return '';
      }
      return _normCell(row[ix]);
    }

    String? rawUrl;
    if (urlIx == scanRowMarker) {
      rawUrl = _firstUrlInRow(row);
    } else {
      rawUrl = _urlFromCell(cellAt(urlIx));
      rawUrl ??= _firstUrlInRow(row);
    }
    if (rawUrl == null || rawUrl.isEmpty) {
      skipped++;
      continue;
    }
    var url = rawUrl.trim();
    if (_isUrlLike(url)) {
      url = url.split(RegExp(r'\s+')).first;
    } else {
      final extracted = _firstUrlInText(url);
      if (extracted != null) {
        url = extracted;
      }
    }
    if (!url.startsWith('http://') &&
        !url.startsWith('https://') &&
        !url.startsWith('www.')) {
      skipped++;
      errs.add('bad_url');
      continue;
    }
    final postingUrl = url.startsWith('www.') ? 'https://$url' : url;
    final title = titleIx != null ? cellAt(titleIx) : '';
    final company = companyIx != null ? cellAt(companyIx) : '';
    final dateRaw = dateIx != null ? cellAt(dateIx) : '';
    DateTime? parsedDate;
    if (dateRaw.isNotEmpty) {
      parsedDate = _parseDateCell(dateRaw);
      if (parsedDate == null) {
        errs.add('bad_date');
      }
    }
    final hadSubmittedOnFromCsvRow =
        dateRaw.isNotEmpty && parsedDate != null;
    final submittedOn =
        parsedDate ?? JobApplication.dateOnly(DateTime.now());
    final statusRaw = statusIx != null ? cellAt(statusIx) : '';
    final status =
        statusRaw.isNotEmpty
            ? _parseStatusCell(statusRaw)
            : JobApplicationStatus.draft;

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
    hadDateFromCsv.add(hadSubmittedOnFromCsvRow);
  }

  return CsvImportResult(
    applications: out,
    skippedCount: skipped,
    errorMessages: errs,
    hadSubmittedOnFromCsv: hadDateFromCsv,
  );
}
