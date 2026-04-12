import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:provider/provider.dart';

import 'package:job_application_tracker/core/interaction/job_track_haptics.dart';
import 'package:job_application_tracker/core/profile/profile_controller.dart';
import 'package:job_application_tracker/core/profile/profile_models.dart';
import 'package:job_application_tracker/features/profile/profile_share_helper.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

enum _ProfileSocialKind { github, gitlab, linkedin, dribbble, behance }

class _SocialSlot {
  _SocialSlot(this.kind, this.controller);

  _ProfileSocialKind kind;
  final TextEditingController controller;
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _displayName;
  late final TextEditingController _headline;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _bio;

  final List<_SocialSlot> _socialSlots = <_SocialSlot>[];

  bool _didSyncFields = false;

  static const double _fieldRadius = 24;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didSyncFields) {
      return;
    }
    _didSyncFields = true;
    final p = context.read<ProfileController>().profile;
    _displayName = TextEditingController(text: p.displayName);
    _headline = TextEditingController(text: p.headline);
    _email = TextEditingController(text: p.email);
    _phone = TextEditingController(text: p.phone);
    _bio = TextEditingController(text: p.bio);
    _initSocialSlotsFromProfile(p);
  }

  void _initSocialSlotsFromProfile(UserProfile p) {
    void addIf(_ProfileSocialKind kind, String? url) {
      final t = url?.trim();
      if (t != null && t.isNotEmpty) {
        _socialSlots.add(_SocialSlot(kind, TextEditingController(text: url)));
      }
    }

    addIf(_ProfileSocialKind.github, p.githubUrl);
    addIf(_ProfileSocialKind.gitlab, p.gitlabUrl);
    addIf(_ProfileSocialKind.linkedin, p.linkedinUrl);
    addIf(_ProfileSocialKind.dribbble, p.dribbbleUrl);
    addIf(_ProfileSocialKind.behance, p.behanceUrl);
  }

  @override
  void dispose() {
    _displayName.dispose();
    _headline.dispose();
    _email.dispose();
    _phone.dispose();
    _bio.dispose();
    for (final s in _socialSlots) {
      s.controller.dispose();
    }
    super.dispose();
  }

  String _kindShort(AppLocalizations l10n, _ProfileSocialKind k) {
    return switch (k) {
      _ProfileSocialKind.github => l10n.socialLinkGithub,
      _ProfileSocialKind.gitlab => l10n.socialLinkGitlab,
      _ProfileSocialKind.linkedin => l10n.socialLinkLinkedin,
      _ProfileSocialKind.dribbble => l10n.socialLinkDribbble,
      _ProfileSocialKind.behance => l10n.socialLinkBehance,
    };
  }

  String _kindUrlLabel(AppLocalizations l10n, _ProfileSocialKind k) {
    return switch (k) {
      _ProfileSocialKind.github => l10n.labelProfileGithub,
      _ProfileSocialKind.gitlab => l10n.labelProfileGitlab,
      _ProfileSocialKind.linkedin => l10n.labelProfileLinkedin,
      _ProfileSocialKind.dribbble => l10n.labelProfileDribbble,
      _ProfileSocialKind.behance => l10n.labelProfileBehance,
    };
  }

  List<_ProfileSocialKind> _kindsForDropdown(int rowIndex) {
    final current = _socialSlots[rowIndex].kind;
    final used = <_ProfileSocialKind>{
      for (var i = 0; i < _socialSlots.length; i++)
        if (i != rowIndex) _socialSlots[i].kind,
    };
    return _ProfileSocialKind.values
        .where((k) => k == current || !used.contains(k))
        .toList();
  }

  void _removeSocialAt(int index) {
    JobTrackHaptics.button();
    final c = _socialSlots[index].controller;
    setState(() {
      _socialSlots.removeAt(index);
    });
    c.dispose();
  }

  void _addSocialSlot() {
    final used = _socialSlots.map((s) => s.kind).toSet();
    if (used.length >= _ProfileSocialKind.values.length) {
      return;
    }
    JobTrackHaptics.button();
    final next = _ProfileSocialKind.values.firstWhere((k) => !used.contains(k));
    setState(() {
      _socialSlots.add(_SocialSlot(next, TextEditingController()));
    });
  }

  bool get _canAddAnotherSocial =>
      _socialSlots.length < _ProfileSocialKind.values.length;

  String? _urlForKind(_ProfileSocialKind kind) {
    for (final s in _socialSlots) {
      if (s.kind == kind) {
        return normalizeOptionalUrl(s.controller.text);
      }
    }
    return null;
  }

  Future<void> _saveProfile() async {
    JobTrackHaptics.button();
    final l10n = context.l10n;
    for (final s in _socialSlots) {
      final t = s.controller.text.trim();
      if (t.isNotEmpty && normalizeOptionalUrl(s.controller.text) == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.profileInvalidUrl)));
        return;
      }
    }

    await context.read<ProfileController>().applyProfileEdits(
      displayName: _displayName.text,
      headline: _headline.text,
      email: _email.text,
      phone: _phone.text,
      bio: _bio.text,
      githubUrl: _urlForKind(_ProfileSocialKind.github),
      gitlabUrl: _urlForKind(_ProfileSocialKind.gitlab),
      linkedinUrl: _urlForKind(_ProfileSocialKind.linkedin),
      dribbbleUrl: _urlForKind(_ProfileSocialKind.dribbble),
      behanceUrl: _urlForKind(_ProfileSocialKind.behance),
    );

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.profileSaved)));
    }
  }

  Future<void> _shareCard() async {
    JobTrackHaptics.button();
    final l10n = context.l10n;
    final draft = _draftProfile();
    if (!profileHasShareableContent(draft)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.profileShareEmpty)));
      return;
    }

    await shareProfileBusinessCard(
      context: context,
      profile: draft,
      l10n: l10n,
      shareSubject: l10n.profileShareSubject,
    );
  }

  UserProfile _draftProfile() {
    return UserProfile(
      displayName: _displayName.text,
      headline: _headline.text,
      email: _email.text,
      phone: _phone.text,
      bio: _bio.text,
      githubUrl: _urlForKind(_ProfileSocialKind.github),
      gitlabUrl: _urlForKind(_ProfileSocialKind.gitlab),
      linkedinUrl: _urlForKind(_ProfileSocialKind.linkedin),
      dribbbleUrl: _urlForKind(_ProfileSocialKind.dribbble),
      behanceUrl: _urlForKind(_ProfileSocialKind.behance),
    );
  }

  Future<void> _addResume() async {
    JobTrackHaptics.button();
    final l10n = context.l10n;
    final err = await context.read<ProfileController>().pickAndAddResume();
    if (!mounted) {
      return;
    }
    if (err == null) {
      return;
    }
    final message = switch (err) {
      'resume_unsupported' => l10n.profileResumeUnsupported,
      'resume_read_failed' => l10n.profileResumeReadFailed,
      'resume_write_failed' => l10n.profileResumeWriteFailed,
      _ => err,
    };
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _openResume(String path) async {
    JobTrackHaptics.button();
    final result = await OpenFilex.open(path);
    if (!mounted) {
      return;
    }
    if (result.type != ResultType.done) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.profileOpenResumeFailed)),
      );
    }
  }

  InputDecoration _pillDecoration(
    BuildContext context, {
    required String labelText,
    String? hintText,
    int maxLines = 1,
  }) {
    final cs = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(_fieldRadius),
      borderSide: BorderSide(color: cs.outlineVariant),
    );
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      filled: true,
      fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.35),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: maxLines > 1 ? 16 : 14,
      ),
      border: border,
      enabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_fieldRadius),
        borderSide: BorderSide(color: cs.primary, width: 2),
      ),
    );
  }

  Widget _sectionCaption(BuildContext context, String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 6),
      child: Text(
        text,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget _buildSocialRow(AppLocalizations l10n, int index) {
    final slot = _socialSlots[index];
    final items = _kindsForDropdown(index);
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(_fieldRadius),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 118,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<_ProfileSocialKind>(
                    isExpanded: true,
                    value: slot.kind,
                    borderRadius: BorderRadius.circular(16),
                    items: items
                        .map(
                          (k) => DropdownMenuItem<_ProfileSocialKind>(
                            value: k,
                            child: Text(
                              _kindShort(l10n, k),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        JobTrackHaptics.selection();
                        setState(() => slot.kind = v);
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: slot.controller,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: _kindUrlLabel(l10n, slot.kind),
                    hintText: l10n.profileUrlHint,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                  ),
                ),
              ),
              IconButton(
                tooltip: l10n.profileRemoveSocialLink,
                icon: const Icon(Icons.close_rounded),
                onPressed: () => _removeSocialAt(index),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final profile = context.watch<ProfileController>().profile;
    final canResume = context.watch<ProfileController>().canUseLocalResumeFiles;
    final cs = theme.colorScheme;
    final pillButtonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_fieldRadius),
    );

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
        children: [
          Text(
            l10n.profileTitle,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.primaryContainer,
              ),
              child: Icon(
                Icons.person_rounded,
                size: 48,
                color: cs.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(height: 22),
          TextField(
            controller: _displayName,
            textCapitalization: TextCapitalization.words,
            decoration: _pillDecoration(
              context,
              labelText: l10n.labelProfileDisplayName,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _headline,
            decoration: _pillDecoration(
              context,
              labelText: l10n.labelProfileHeadline,
            ),
          ),
          const SizedBox(height: 20),
          _sectionCaption(context, l10n.profileSectionContact),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: _pillDecoration(
              context,
              labelText: l10n.labelProfileEmail,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: _pillDecoration(
              context,
              labelText: l10n.labelProfilePhone,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _bio,
            maxLines: 4,
            minLines: 3,
            decoration: _pillDecoration(
              context,
              labelText: l10n.labelProfileBio,
              maxLines: 4,
            ),
          ),
          const SizedBox(height: 20),
          _sectionCaption(context, l10n.profileSectionSocial),
          Text(
            l10n.profileSocialLinksEmptyHint,
            style: theme.textTheme.bodySmall?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < _socialSlots.length; i++)
            _buildSocialRow(l10n, i),
          if (_canAddAnotherSocial)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: _addSocialSlot,
                icon: const Icon(Icons.add_rounded, size: 22),
                label: Text(l10n.profileAddSocialLink),
                style: TextButton.styleFrom(
                  foregroundColor: cs.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 16),
          _sectionCaption(context, l10n.profileSectionResumes),
          if (!canResume)
            Text(
              l10n.profileResumeUnsupported,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            )
          else
            FilledButton.tonalIcon(
              style: FilledButton.styleFrom(
                shape: pillButtonShape,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
              ),
              onPressed: _addResume,
              icon: const Icon(Icons.upload_file_outlined),
              label: Text(l10n.profileAddResume),
            ),
          const SizedBox(height: 6),
          ...profile.resumes.map(
            (r) => ListTile(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(r.fileName),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (canResume)
                    TextButton(
                      onPressed: () => _openResume(r.storedPath),
                      child: Text(l10n.profileOpenResume),
                    ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: l10n.profileRemoveResume,
                    onPressed: () {
                      JobTrackHaptics.button();
                      context.read<ProfileController>().removeResume(r.id);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          FilledButton(
            style: FilledButton.styleFrom(
              shape: pillButtonShape,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: _saveProfile,
            child: Text(l10n.profileSave),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              shape: pillButtonShape,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: _shareCard,
            icon: const Icon(Icons.share_outlined),
            label: Text(l10n.profileShare),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}
