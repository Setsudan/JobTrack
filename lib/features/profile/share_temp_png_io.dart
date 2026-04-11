import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> writeTempProfilePng(List<int> bytes) async {
  final dir = await getTemporaryDirectory();
  final path = '${dir.path}${Platform.pathSeparator}jobtrack_profile_card.png';
  await File(path).writeAsBytes(bytes, flush: true);
  return path;
}
