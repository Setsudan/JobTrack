import 'package:flutter/material.dart';

import 'package:job_application_tracker/core/profile/profile_models.dart';
import 'package:job_application_tracker/l10n/app_localizations.dart';

class ProfileBusinessCard extends StatelessWidget {
  const ProfileBusinessCard({
    super.key,
    required this.profile,
    required this.l10n,
    required this.colorScheme,
  });

  final UserProfile profile;
  final AppLocalizations l10n;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: colorScheme.surface,
      child: Container(
        width: 900,
        height: 500,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outlineVariant, width: 2),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primaryContainer.withValues(alpha: 0.35),
              colorScheme.surface,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (profile.displayName.trim().isNotEmpty)
              Text(
                profile.displayName.trim(),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            if (profile.headline.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                profile.headline.trim(),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ],
            if (profile.email.trim().isNotEmpty ||
                profile.phone.trim().isNotEmpty) ...[
              const SizedBox(height: 20),
              if (profile.email.trim().isNotEmpty)
                Text(
                  profile.email.trim(),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              if (profile.phone.trim().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    profile.phone.trim(),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
            ],
            if (profile.bio.trim().isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                profile.bio.trim(),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const Spacer(),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _socialRows(l10n, profile),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _socialRows(AppLocalizations l10n, UserProfile p) {
    final rows = <Widget>[];
    void add(String label, String? url) {
      final u = url?.trim();
      if (u == null || u.isEmpty) {
        return;
      }
      rows.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    add(l10n.socialLinkGithub, p.githubUrl);
    add(l10n.socialLinkGitlab, p.gitlabUrl);
    add(l10n.socialLinkLinkedin, p.linkedinUrl);
    add(l10n.socialLinkDribbble, p.dribbbleUrl);
    add(l10n.socialLinkBehance, p.behanceUrl);
    return rows;
  }
}
