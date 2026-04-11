class ResumeAttachment {
  const ResumeAttachment({
    required this.id,
    required this.fileName,
    required this.storedPath,
  });

  final String id;
  final String fileName;
  final String storedPath;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'fileName': fileName,
    'storedPath': storedPath,
  };

  static ResumeAttachment fromJson(Map<String, dynamic> json) {
    return ResumeAttachment(
      id: json['id'] as String,
      fileName: json['fileName'] as String,
      storedPath: json['storedPath'] as String,
    );
  }
}

class UserProfile {
  UserProfile({
    this.displayName = '',
    this.headline = '',
    this.email = '',
    this.phone = '',
    this.bio = '',
    this.githubUrl,
    this.gitlabUrl,
    this.linkedinUrl,
    this.dribbbleUrl,
    this.behanceUrl,
    List<ResumeAttachment>? resumes,
  }) : resumes = resumes ?? <ResumeAttachment>[];

  String displayName;
  String headline;
  String email;
  String phone;
  String bio;
  String? githubUrl;
  String? gitlabUrl;
  String? linkedinUrl;
  String? dribbbleUrl;
  String? behanceUrl;
  List<ResumeAttachment> resumes;

  UserProfile copy() {
    return UserProfile(
      displayName: displayName,
      headline: headline,
      email: email,
      phone: phone,
      bio: bio,
      githubUrl: githubUrl,
      gitlabUrl: gitlabUrl,
      linkedinUrl: linkedinUrl,
      dribbbleUrl: dribbbleUrl,
      behanceUrl: behanceUrl,
      resumes: resumes
          .map(
            (r) => ResumeAttachment(
              id: r.id,
              fileName: r.fileName,
              storedPath: r.storedPath,
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'displayName': displayName,
    'headline': headline,
    'email': email,
    'phone': phone,
    'bio': bio,
    'githubUrl': githubUrl,
    'gitlabUrl': gitlabUrl,
    'linkedinUrl': linkedinUrl,
    'dribbbleUrl': dribbbleUrl,
    'behanceUrl': behanceUrl,
    'resumes': resumes.map((r) => r.toJson()).toList(),
  };

  static UserProfile fromJson(Map<String, dynamic> json) {
    final rawResumes = json['resumes'];
    return UserProfile(
      displayName: json['displayName'] as String? ?? '',
      headline: json['headline'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      githubUrl: json['githubUrl'] as String?,
      gitlabUrl: json['gitlabUrl'] as String?,
      linkedinUrl: json['linkedinUrl'] as String?,
      dribbbleUrl: json['dribbbleUrl'] as String?,
      behanceUrl: json['behanceUrl'] as String?,
      resumes: rawResumes is List<dynamic>
          ? rawResumes
                .map(
                  (e) => ResumeAttachment.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : <ResumeAttachment>[],
    );
  }
}

String? normalizeOptionalUrl(String? raw) {
  final t = raw?.trim();
  if (t == null || t.isEmpty) {
    return null;
  }
  var u = t;
  if (!u.contains('://')) {
    u = 'https://$u';
  }
  final parsed = Uri.tryParse(u);
  if (parsed == null || !parsed.hasScheme || parsed.host.isEmpty) {
    return null;
  }
  return u;
}

bool profileHasShareableContent(UserProfile p) {
  if (p.displayName.trim().isNotEmpty) {
    return true;
  }
  if (p.headline.trim().isNotEmpty) {
    return true;
  }
  if (p.email.trim().isNotEmpty) {
    return true;
  }
  if (p.phone.trim().isNotEmpty) {
    return true;
  }
  if (p.bio.trim().isNotEmpty) {
    return true;
  }
  if (p.githubUrl != null && p.githubUrl!.isNotEmpty) {
    return true;
  }
  if (p.gitlabUrl != null && p.gitlabUrl!.isNotEmpty) {
    return true;
  }
  if (p.linkedinUrl != null && p.linkedinUrl!.isNotEmpty) {
    return true;
  }
  if (p.dribbbleUrl != null && p.dribbbleUrl!.isNotEmpty) {
    return true;
  }
  if (p.behanceUrl != null && p.behanceUrl!.isNotEmpty) {
    return true;
  }
  return false;
}
