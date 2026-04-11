import 'dart:convert';

import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;

class JobPostingMetadataResult {
  const JobPostingMetadataResult({this.titleGuess, this.companyGuess});

  final String? titleGuess;
  final String? companyGuess;
}

class JobPostingMetadataService {
  JobPostingMetadataService({http.Client? httpClient})
    : _client = httpClient ?? http.Client(),
      _ownsClient = httpClient == null;

  final http.Client _client;
  final bool _ownsClient;

  static const int _maxBodyBytes = 512 * 1024;

  void dispose() {
    if (_ownsClient) {
      _client.close();
    }
  }

  Future<JobPostingMetadataResult> fetchHints(String normalizedUrl) async {
    final uri = Uri.tryParse(normalizedUrl);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
      return const JobPostingMetadataResult();
    }
    try {
      final request = http.Request('GET', uri);
      request.headers['User-Agent'] = 'JobTrack/1.0';
      final streamed = await _client
          .send(request)
          .timeout(const Duration(seconds: 12));
      final chunks = <int>[];
      var total = 0;
      await for (final chunk in streamed.stream.timeout(
        const Duration(seconds: 15),
      )) {
        final remaining = _maxBodyBytes - total;
        if (remaining <= 0) {
          break;
        }
        if (chunk.length <= remaining) {
          chunks.addAll(chunk);
          total += chunk.length;
        } else {
          chunks.addAll(chunk.sublist(0, remaining));
          total += remaining;
          break;
        }
      }
      if (streamed.statusCode < 200 || streamed.statusCode >= 300) {
        return const JobPostingMetadataResult();
      }
      final body = utf8.decode(chunks, allowMalformed: true);
      return _parseHtml(body);
    } catch (_) {
      return const JobPostingMetadataResult();
    }
  }

  JobPostingMetadataResult _parseHtml(String html) {
    final doc = html_parser.parse(html);
    String? meta(String property) {
      final byProp = doc.querySelector('meta[property="$property"]');
      final c1 = byProp?.attributes['content']?.trim();
      if (c1 != null && c1.isNotEmpty) {
        return c1;
      }
      final byName = doc.querySelector('meta[name="$property"]');
      final c2 = byName?.attributes['content']?.trim();
      if (c2 != null && c2.isNotEmpty) {
        return c2;
      }
      return null;
    }

    final ogTitle = meta('og:title');
    final twitterTitle = meta('twitter:title');
    final siteName = meta('og:site_name');
    final titleEl = doc.querySelector('title')?.text.trim();
    final primaryTitle = _nonEmpty([ogTitle, twitterTitle, titleEl]);

    if (primaryTitle == null) {
      return JobPostingMetadataResult(
        titleGuess: null,
        companyGuess: _cleanCompany(siteName),
      );
    }

    final split = _splitTitleAndCompany(primaryTitle, siteName);
    return JobPostingMetadataResult(
      titleGuess: split.$1,
      companyGuess: split.$2 ?? _cleanCompany(siteName),
    );
  }

  static String? _nonEmpty(List<String?> candidates) {
    for (final c in candidates) {
      if (c != null && c.trim().isNotEmpty) {
        return c.trim();
      }
    }
    return null;
  }

  static String? _cleanCompany(String? raw) {
    if (raw == null) {
      return null;
    }
    final t = raw.trim();
    return t.isEmpty ? null : t;
  }

  static (String, String?) _splitTitleAndCompany(
    String title,
    String? siteName,
  ) {
    for (final sep in [' | ', ' – ', ' — ', ' - ', ' |', '| ']) {
      final i = title.indexOf(sep);
      if (i > 0 && i < title.length - sep.length) {
        final a = title.substring(0, i).trim();
        final b = title.substring(i + sep.length).trim();
        if (a.isNotEmpty && b.isNotEmpty) {
          final site = siteName?.trim().toLowerCase() ?? '';
          if (site.isNotEmpty && a.toLowerCase() == site) {
            return (b, a);
          }
          if (site.isNotEmpty && b.toLowerCase() == site) {
            return (a, b);
          }
          return (a, b);
        }
      }
    }
    return (title, null);
  }
}
