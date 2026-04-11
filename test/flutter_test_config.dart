import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:isar/isar.dart';

String _isarCoreLibraryFileName() {
  if (Platform.isWindows) {
    return 'isar.dll';
  }
  if (Platform.isMacOS) {
    return 'libisar.dylib';
  }
  return 'libisar.so';
}

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  Directory? tempCoreDir;
  if (!Platform.isIOS) {
    tempCoreDir = await Directory.systemTemp.createTemp('jt_isar_core_');
    final String libPath =
        '${tempCoreDir.path}${Platform.pathSeparator}${_isarCoreLibraryFileName()}';
    await Isar.initializeIsarCore(
      libraries: <Abi, String>{Abi.current(): libPath},
      download: true,
    );
  } else {
    await Isar.initializeIsarCore();
  }
  try {
    await testMain();
  } finally {
    if (tempCoreDir != null) {
      try {
        await tempCoreDir.delete(recursive: true);
      } catch (_) {}
    }
  }
}
