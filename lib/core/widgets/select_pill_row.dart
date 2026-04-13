import 'package:flutter/material.dart';

import 'package:job_application_tracker/core/interaction/job_track_haptics.dart';

class SelectPillRow<T> extends StatelessWidget {
  const SelectPillRow({
    super.key,
    required this.value,
    required this.entries,
    required this.onSelected,
  });

  final T value;
  final List<(T, String)> entries;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final (id, label) in entries)
          SelectPill(
            label: label,
            selected: id == value,
            onTap: () => onSelected(id),
            colorScheme: cs,
            textTheme: theme.textTheme,
          ),
      ],
    );
  }
}

class SelectPill extends StatelessWidget {
  const SelectPill({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.colorScheme,
    required this.textTheme,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final bg = selected
        ? colorScheme.primaryContainer
        : colorScheme.surfaceContainerHighest;
    final fg = selected
        ? colorScheme.onPrimaryContainer
        : colorScheme.onSurfaceVariant;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: () {
          JobTrackHaptics.button();
          onTap();
        },
        borderRadius: BorderRadius.circular(22),
        splashColor: colorScheme.primary.withValues(alpha: 0.12),
        highlightColor: colorScheme.primary.withValues(alpha: 0.06),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          child: Text(
            label,
            style: textTheme.labelLarge?.copyWith(
              color: fg,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              letterSpacing: -0.1,
            ),
          ),
        ),
      ),
    );
  }
}

class DualSegmentPill extends StatelessWidget {
  const DualSegmentPill({
    super.key,
    required this.value,
    required this.onSelected,
    required this.firstLabel,
    required this.secondLabel,
  });

  /// `false` selects [firstLabel]; `true` selects [secondLabel].
  final bool value;
  final ValueChanged<bool> onSelected;
  final String firstLabel;
  final String secondLabel;

  static const double _radius = 22;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final textTheme = theme.textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(_radius),
      child: Material(
        color: cs.surfaceContainerHighest,
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Segment(
                label: firstLabel,
                selected: !value,
                onTap: () => onSelected(false),
                colorScheme: cs,
                textTheme: textTheme,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(_radius),
                  right: Radius.circular(8),
                ),
                inkBorderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(_radius),
                ),
              ),
              Center(
                child: Container(
                  width: 1,
                  height: 22,
                  color: cs.outlineVariant,
                ),
              ),
              _Segment(
                label: secondLabel,
                selected: value,
                onTap: () => onSelected(true),
                colorScheme: cs,
                textTheme: textTheme,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(8),
                  right: Radius.circular(_radius),
                ),
                inkBorderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(_radius),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.colorScheme,
    required this.textTheme,
    required this.borderRadius,
    required this.inkBorderRadius,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final BorderRadius borderRadius;
  final BorderRadius inkBorderRadius;

  @override
  Widget build(BuildContext context) {
    final fg = selected
        ? colorScheme.onPrimaryContainer
        : colorScheme.onSurfaceVariant;

    Widget child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      child: Text(
        label,
        style: textTheme.labelLarge?.copyWith(
          color: fg,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          letterSpacing: -0.1,
        ),
      ),
    );

    if (selected) {
      child = DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: borderRadius,
        ),
        child: child,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          JobTrackHaptics.button();
          onTap();
        },
        borderRadius: inkBorderRadius,
        splashColor: colorScheme.primary.withValues(alpha: 0.12),
        highlightColor: colorScheme.primary.withValues(alpha: 0.06),
        child: child,
      ),
    );
  }
}
