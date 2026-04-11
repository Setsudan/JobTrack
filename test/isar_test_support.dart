import 'dart:io';

import 'package:isar/isar.dart';

import 'package:job_application_tracker/data/isar/app_isar.dart';

typedef EphemeralIsar = ({Isar isar, Directory dir});

Future<EphemeralIsar> openEphemeralJobTrackIsar() async {
  final Directory dir = await Directory.systemTemp.createTemp(
    'jobtrack_isar_test_',
  );
  final Isar isar = await openJobTrackIsarInDirectory(
    dir.path,
    name: 't_${DateTime.now().microsecondsSinceEpoch}',
  );
  await ensureIsarSingletonDefaults(isar);
  return (isar: isar, dir: dir);
}

Future<void> closeEphemeralIsar(Isar isar, Directory dir) async {
  await isar.close(deleteFromDisk: true);
  if (dir.existsSync()) {
    await dir.delete(recursive: true);
  }
}
