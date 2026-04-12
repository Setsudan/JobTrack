import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// File-backed error logging plus [developer.log] so crashes are visible in
/// `adb logcat` and a path can be retrieved from a failing device.
abstract final class CrashDiagnostics {
  static String? logFilePath;

  static Future<void> install() async {
    final Directory dir = await getApplicationSupportDirectory();
    logFilePath = p.join(dir.path, 'jobtrack_errors.log');
    _appendFileSync('--- JobTrack session ${DateTime.now().toIso8601String()} ---');

    final FlutterExceptionHandler? previous = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      unawaited(record(details.exception, details.stack, label: 'FlutterError'));
      if (previous != null) {
        previous(details);
      } else {
        FlutterError.presentError(details);
      }
    };

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      recordSync(error, stack, label: 'PlatformDispatcher');
      return false;
    };
  }

  static Future<void> record(
    Object error,
    StackTrace? stack, {
    String label = '',
  }) async {
    _logDeveloper(label, error, stack);
    await _appendFileAsync(_format(label, error, stack));
  }

  static void recordSync(
    Object error,
    StackTrace? stack, {
    String label = '',
  }) {
    _logDeveloper(label, error, stack);
    _appendFileSync(_format(label, error, stack));
  }

  static void _logDeveloper(String label, Object error, StackTrace? stack) {
    final String prefix = label.isEmpty ? 'JobTrack' : 'JobTrack.$label';
    developer.log(
      error.toString(),
      name: prefix,
      error: error is Error ? error : null,
      stackTrace: stack,
    );
  }

  static String _format(String label, Object error, StackTrace? stack) {
    final String head = label.isEmpty ? 'ERROR' : 'ERROR [$label]';
    final String body = stack == null ? error.toString() : '$error\n$stack';
    return '$head at ${DateTime.now().toIso8601String()}\n$body\n';
  }

  static void _appendFileSync(String text) {
    final String? path = logFilePath;
    if (path == null) {
      return;
    }
    try {
      File(path).writeAsStringSync(text, mode: FileMode.append, flush: true);
    } catch (_) {}
  }

  static Future<void> _appendFileAsync(String text) async {
    final String? path = logFilePath;
    if (path == null) {
      return;
    }
    try {
      final File f = File(path);
      await f.writeAsString(text, mode: FileMode.append, flush: true);
    } catch (_) {}
  }
}
