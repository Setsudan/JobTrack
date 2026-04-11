import 'package:flutter/material.dart';

import 'package:job_application_tracker/core/models/job_application_status.dart';
import 'package:job_application_tracker/core/theme/job_application_status_color_scheme.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

class JobApplicationStatusChip extends StatelessWidget {
  const JobApplicationStatusChip({required this.status, super.key});

  final JobApplicationStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    final tones = status.chipTones(theme.brightness);
    final pillBackground = Color.alphaBlend(
      tones.background.withValues(alpha: 0.78),
      scheme.surfaceContainerHigh,
    );
    final pillForeground =
        Color.lerp(tones.foreground, scheme.onSurface, 0.12) ??
        tones.foreground;
    return Chip(
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
        side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.55)),
      ),
      label: Text(
        status.localize(l10n),
        style: theme.textTheme.labelSmall?.copyWith(
          color: pillForeground,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: pillBackground,
      labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
