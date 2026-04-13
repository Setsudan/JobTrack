import 'package:flutter/material.dart';

import 'package:job_application_tracker/core/interaction/job_track_haptics.dart';

class HomeStatCard extends StatelessWidget {
  const HomeStatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.iconBackground,
    required this.iconColor,
    this.progress,
    this.onTap,
    super.key,
  });

  static const double _cardRadius = 24;
  static const double _tileHeight = 160;

  final IconData icon;
  final String title;
  final int value;
  final Color iconBackground;
  final Color iconColor;
  final double? progress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final valueLabel = value.toString();
    final semanticsLabel = '$valueLabel, $title';

    Widget content = ExcludeSemantics(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconBackground.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 20, color: iconColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: scheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: Text(
                valueLabel,
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.0,
                  color: scheme.onSurface,
                ),
              ),
            ),
            if (progress != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: progress!.clamp(0, 1),
                  minHeight: 6,
                  backgroundColor: scheme.surfaceContainerHighest,
                  color: iconColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );

    if (onTap != null) {
      content = InkWell(
        onTap: () {
          JobTrackHaptics.button();
          onTap!();
        },
        borderRadius: BorderRadius.circular(_cardRadius),
        child: content,
      );
    }

    return Semantics(
      container: true,
      label: semanticsLabel,
      child: SizedBox(
        height: _tileHeight,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: content,
        ),
      ),
    );
  }
}
