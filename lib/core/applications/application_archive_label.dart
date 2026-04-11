String normalizeJobTitleKey(String raw) {
  final t = raw.trim().toLowerCase();
  if (t.isEmpty) {
    return '';
  }
  return t.replaceAll(RegExp(r'\s+'), ' ');
}

/// Picks the most frequent non-empty job title (normalized); tie-break: lexicographic on key.
String modeDisplayJobTitle(Iterable<String> titles) {
  final counts = <String, int>{};
  final keyToExampleRaw = <String, String>{};
  for (final raw in titles) {
    final key = normalizeJobTitleKey(raw);
    if (key.isEmpty) {
      continue;
    }
    counts[key] = (counts[key] ?? 0) + 1;
    keyToExampleRaw.putIfAbsent(key, () => raw.trim());
  }
  if (counts.isEmpty) {
    return '';
  }
  var bestKey = '';
  var bestCount = -1;
  for (final e in counts.entries) {
    if (e.value > bestCount) {
      bestCount = e.value;
      bestKey = e.key;
    } else if (e.value == bestCount && e.key.compareTo(bestKey) < 0) {
      bestKey = e.key;
    }
  }
  return keyToExampleRaw[bestKey] ?? '';
}

bool isFirstSemester(DateTime d) => d.month <= 6;

String archiveGroupKeyFor({
  required DateTime at,
  required String displayJobTitle,
}) {
  final half = isFirstSemester(at) ? 'H1' : 'H2';
  final slug = normalizeJobTitleKey(displayJobTitle).replaceAll(' ', '-');
  return '${at.year}-$half|$slug';
}
