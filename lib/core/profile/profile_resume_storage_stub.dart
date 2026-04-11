Future<void> ensureResumesParentExists(String documentsPath) async {}

Future<void> writeBytesToPath(String fullPath, List<int> bytes) async {}

Future<void> deletePathIfExists(String fullPath) async {}

Future<List<int>> readBytesFromPath(String path) async {
  throw UnsupportedError('readBytesFromPath');
}
