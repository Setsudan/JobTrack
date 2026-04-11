import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:job_application_tracker/core/profile/profile_models.dart';
import 'package:job_application_tracker/core/profile/profile_resume_storage.dart';
import 'package:job_application_tracker/data/isar/isar_schemas.dart';

class ProfileController extends ChangeNotifier {
  ProfileController(this._isar);

  final Isar _isar;

  UserProfile _profile = UserProfile();
  String? _documentsPath;
  bool _storageReady = false;

  UserProfile get profile => _profile;

  bool get canUseLocalResumeFiles => !kIsWeb && _storageReady;

  Future<void> init() async {
    _loadFromIsar();
    if (!kIsWeb) {
      try {
        final dir = await getApplicationDocumentsDirectory();
        _documentsPath = dir.path;
        await ensureResumesParentExists(_documentsPath!);
        _storageReady = true;
      } catch (_) {
        _storageReady = false;
      }
    }
    notifyListeners();
  }

  void _loadFromIsar() {
    final UserProfileEntity? row = _isar.userProfileEntitys.getByRowKeySync(
      kSingletonProfile,
    );
    final String raw = row?.profileJson ?? '';
    if (raw.isEmpty) {
      _profile = UserProfile();
      return;
    }
    try {
      final Map<String, dynamic> map = jsonDecode(raw) as Map<String, dynamic>;
      _profile = UserProfile.fromJson(map);
    } catch (_) {
      _profile = UserProfile();
    }
  }

  Future<void> _persist() async {
    await _isar.writeTxn(() async {
      final UserProfileEntity? row = await _isar.userProfileEntitys
          .filter()
          .rowKeyEqualTo(kSingletonProfile)
          .findFirst();
      if (row == null) {
        return;
      }
      row.profileJson = jsonEncode(_profile.toJson());
      await _isar.userProfileEntitys.put(row);
    });
    notifyListeners();
  }

  Future<void> applyProfileEdits({
    required String displayName,
    required String headline,
    required String email,
    required String phone,
    required String bio,
    required String? githubUrl,
    required String? gitlabUrl,
    required String? linkedinUrl,
    required String? dribbbleUrl,
    required String? behanceUrl,
  }) async {
    _profile.displayName = displayName;
    _profile.headline = headline;
    _profile.email = email;
    _profile.phone = phone;
    _profile.bio = bio;
    _profile.githubUrl = githubUrl;
    _profile.gitlabUrl = gitlabUrl;
    _profile.linkedinUrl = linkedinUrl;
    _profile.dribbbleUrl = dribbbleUrl;
    _profile.behanceUrl = behanceUrl;
    await _persist();
  }

  /// Returns null on success, or an error code string for the UI.
  Future<String?> pickAndAddResume() async {
    if (!canUseLocalResumeFiles || _documentsPath == null) {
      return 'resume_unsupported';
    }
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const <String>['pdf', 'doc', 'docx'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) {
      return null;
    }
    final f = result.files.single;
    List<int>? bytes = f.bytes;
    if (bytes == null && f.path != null && !kIsWeb) {
      try {
        bytes = await readBytesFromPath(f.path!);
      } catch (_) {
        return 'resume_read_failed';
      }
    }
    if (bytes == null || bytes.isEmpty) {
      return 'resume_read_failed';
    }
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final originalName = f.name.trim().isEmpty ? 'resume' : f.name.trim();
    var ext = '';
    final dot = originalName.lastIndexOf('.');
    if (dot > 0 && dot < originalName.length - 1) {
      ext = '.${originalName.substring(dot + 1).toLowerCase()}';
      if (ext.length > 6) {
        ext = '.pdf';
      }
    } else {
      ext = '.pdf';
    }
    final storedFileName = '$id$ext';
    final fullPath = '$_documentsPath/resumes/$storedFileName';
    try {
      await writeBytesToPath(fullPath, bytes);
    } catch (_) {
      return 'resume_write_failed';
    }
    _profile.resumes.add(
      ResumeAttachment(id: id, fileName: originalName, storedPath: fullPath),
    );
    await _persist();
    return null;
  }

  Future<void> removeResume(String id) async {
    final idx = _profile.resumes.indexWhere((ResumeAttachment r) => r.id == id);
    if (idx < 0) {
      return;
    }
    final path = _profile.resumes[idx].storedPath;
    _profile.resumes.removeAt(idx);
    await _persist();
    if (!kIsWeb) {
      await deletePathIfExists(path);
    }
  }
}
