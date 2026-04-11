import 'dart:io';

Future<void> ensureResumesParentExists(String documentsPath) async {
  final dir = Directory('$documentsPath/resumes');
  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }
}

Future<void> writeBytesToPath(String fullPath, List<int> bytes) async {
  final file = File(fullPath);
  await file.writeAsBytes(bytes, flush: true);
}

Future<void> deletePathIfExists(String fullPath) async {
  final f = File(fullPath);
  if (await f.exists()) {
    await f.delete();
  }
}

Future<List<int>> readBytesFromPath(String path) {
  return File(path).readAsBytes();
}
