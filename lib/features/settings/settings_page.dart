import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:job_application_tracker/core/applications/applications_controller.dart';
import 'package:job_application_tracker/core/interaction/job_track_haptics.dart';
import 'package:job_application_tracker/core/applications/swipe_status_actions.dart';
import 'package:job_application_tracker/core/models/job_application_status.dart';
import 'package:job_application_tracker/core/settings/app_appearance.dart';
import 'package:job_application_tracker/core/settings/app_background_kind.dart';
import 'package:job_application_tracker/core/settings/app_background_presets.dart';
import 'package:job_application_tracker/core/settings/background_image_import_result.dart';
import 'package:job_application_tracker/core/settings/background_image_pick_outcome.dart';
import 'package:job_application_tracker/core/settings/settings_controller.dart';
import 'package:job_application_tracker/core/theme/app_theme.dart';
import 'package:job_application_tracker/features/settings/wallpaper_crop_page.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final settings = context.watch<SettingsController>();
    context.select<ApplicationsController, int>((ApplicationsController c) {
      return c.changeSignature;
    });
    final ApplicationsController apps = context.read<ApplicationsController>();
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final trackedCount =
        apps.activeApplications().length + apps.archivedApplications().length;

    return Scaffold(
      backgroundColor:
          settings.wallpaperActive ? Colors.transparent : cs.surface,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(l10n.settingsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          Text(
            l10n.foundationBlurb,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.onSurfaceVariant,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.applicationsCount(trackedCount),
            style: theme.textTheme.bodySmall?.copyWith(
              color: cs.onSurfaceVariant.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 28),
          _SettingsSection(
            title: l10n.sectionAppearance,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.labelBackground,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                _PillRow<AppAppearance>(
                  value: settings.appearance,
                  onSelected: (v) =>
                      context.read<SettingsController>().setAppearance(v),
                  entries: [
                    (AppAppearance.system, l10n.appearanceSystem),
                    (AppAppearance.light, l10n.appearanceWhite),
                    (AppAppearance.dark, l10n.appearanceBlack),
                    (AppAppearance.amoledBlack, l10n.appearanceAmoledBlack),
                  ],
                ),
              ],
            ),
          ),
          _SettingsSection(
            title: l10n.sectionAppWallpaper,
            child: const _AppWallpaperSettingsBody(),
          ),
          _SettingsSection(
            title: l10n.sectionLanguage,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.labelDisplayLanguage,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                _PillRow<String>(
                  value: settings.languageCodeKey,
                  onSelected: (v) =>
                      context.read<SettingsController>().setLanguageCode(v),
                  entries: [
                    ('system', l10n.languageSystem),
                    ('en', l10n.languageEnglish),
                    ('fr', l10n.languageFrench),
                  ],
                ),
              ],
            ),
          ),
          _SettingsSection(
            title: l10n.sectionSwipeShortcuts,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.settingsSwipeStartPaneLabel,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.settingsSwipeStartPaneHint,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  // ignore: deprecated_member_use
                  value: _coerceSwipeStorage(
                    settings.swipeStartPaneAction,
                    startPane: true,
                  ),
                  decoration: const InputDecoration(),
                  dropdownColor: AppTheme.dropdownMenuBackground(cs),
                  isExpanded: true,
                  items: _swipeMenuItems(l10n),
                  onChanged: (String? v) {
                    if (v != null) {
                      JobTrackHaptics.selection();
                      context.read<SettingsController>().setSwipeStartPaneAction(
                            v,
                          );
                    }
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.settingsSwipeEndPaneLabel,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.settingsSwipeEndPaneHint,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  // ignore: deprecated_member_use
                  value: _coerceSwipeStorage(
                    settings.swipeEndPaneAction,
                    startPane: false,
                  ),
                  decoration: const InputDecoration(),
                  dropdownColor: AppTheme.dropdownMenuBackground(cs),
                  isExpanded: true,
                  items: _swipeMenuItems(l10n),
                  onChanged: (String? v) {
                    if (v != null) {
                      JobTrackHaptics.selection();
                      context.read<SettingsController>().setSwipeEndPaneAction(
                            v,
                          );
                    }
                  },
                ),
              ],
            ),
          ),
          _SettingsSection(
            title: l10n.sectionFollowUpReminders,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.settingsWaitingFollowUpDaysLabel,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.settingsWaitingFollowUpDaysHint,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                const _FollowUpDaysSlider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<DropdownMenuItem<String>> _swipeMenuItems(AppLocalizations l10n) {
  final items = <DropdownMenuItem<String>>[
    DropdownMenuItem<String>(
      value: swipeActionAdvanceStorageValue,
      child: Text(l10n.swipeShortcutAdvanceLabel),
    ),
    ...JobApplicationStatus.values.map(
      (JobApplicationStatus s) => DropdownMenuItem<String>(
        value: s.name,
        child: Text(s.localize(l10n)),
      ),
    ),
  ];
  return items;
}

String _coerceSwipeStorage(String raw, {required bool startPane}) {
  if (raw == swipeActionAdvanceStorageValue) {
    return raw;
  }
  try {
    JobApplicationStatus.values.byName(raw);
    return raw;
  } catch (_) {
    return startPane
        ? swipeActionAdvanceStorageValue
        : 'closedNotSelected';
  }
}

Future<void> _pickAlignAndCommitWallpaper(BuildContext context) async {
  final AppLocalizations l10n = context.l10n;
  final SettingsController c = context.read<SettingsController>();
  final BackgroundImagePickOutcome pick = await c.pickBackgroundImageSource();
  if (!context.mounted) {
    return;
  }
  switch (pick) {
    case BackgroundImagePickCancelled():
      return;
    case BackgroundImagePickInvalid():
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.appWallpaperImageImportFailed)),
      );
      return;
    case BackgroundImagePickResolved(:final sourcePath):
      await _readCropAndCommitWallpaper(
        context,
        c,
        l10n,
        sourcePath,
      );
  }
}

Future<void> _readCropAndCommitWallpaper(
  BuildContext context,
  SettingsController c,
  AppLocalizations l10n,
  String sourcePath,
) async {
  late final Uint8List bytes;
  try {
    bytes = await File(sourcePath).readAsBytes();
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.appWallpaperImageImportFailed)),
      );
    }
    return;
  }
  if (!context.mounted) {
    return;
  }
  final Size mqSize = MediaQuery.sizeOf(context);
  final double ar =
      mqSize.height > 0 ? mqSize.width / mqSize.height : 9 / 16;
  final Uint8List? cropped = await Navigator.of(context).push<Uint8List?>(
    MaterialPageRoute<Uint8List?>(
      fullscreenDialog: true,
      builder: (BuildContext ctx) => WallpaperCropPage(
        imageBytes: bytes,
        cropAspectRatio: ar,
      ),
    ),
  );
  if (!context.mounted || cropped == null) {
    return;
  }
  final BackgroundImageImportResult r = await c.commitWallpaperPng(cropped);
  if (!context.mounted) {
    return;
  }
  if (r == BackgroundImageImportResult.failed) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.appWallpaperImageImportFailed)),
    );
  }
}

class _AppWallpaperSettingsBody extends StatelessWidget {
  const _AppWallpaperSettingsBody();

  @override
  Widget build(BuildContext context) {
    final SettingsController settings = context.watch<SettingsController>();
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppBackgroundKind kind = settings.appBackgroundKind;
    final bool hasImage =
        settings.appBackgroundImageFileName != null &&
        settings.backgroundImageFileIfExists() != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _PillRow<AppBackgroundKind>(
          value: kind,
          onSelected: (AppBackgroundKind v) async {
            JobTrackHaptics.button();
            final SettingsController c = context.read<SettingsController>();
            if (v == AppBackgroundKind.none) {
              await c.setAppBackgroundNone();
            } else if (v == AppBackgroundKind.image) {
              await _pickAlignAndCommitWallpaper(context);
            } else if (v == AppBackgroundKind.gradient) {
              await c.setAppBackgroundGradient(
                AppBackgroundPresets.resolveStaticPresetId(
                  c.appBackgroundPresetId,
                ),
              );
            } else if (v == AppBackgroundKind.gradientAnimated) {
              await c.setAppBackgroundAnimated(
                AppBackgroundPresets.resolveAnimatedPresetId(
                  c.appBackgroundPresetId,
                ),
              );
            }
          },
          entries: <(AppBackgroundKind, String)>[
            (AppBackgroundKind.none, l10n.appWallpaperModeNone),
            (AppBackgroundKind.image, l10n.appWallpaperModeImage),
            (AppBackgroundKind.gradient, l10n.appWallpaperModeGradient),
            (
              AppBackgroundKind.gradientAnimated,
              l10n.appWallpaperModeAnimated,
            ),
          ],
        ),
        if (kind == AppBackgroundKind.image) ...<Widget>[
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: <Widget>[
              FilledButton.tonal(
                onPressed: () async {
                  JobTrackHaptics.button();
                  await _pickAlignAndCommitWallpaper(context);
                },
                child: Text(l10n.appWallpaperChooseImage),
              ),
              if (hasImage)
                TextButton(
                  onPressed: () {
                    JobTrackHaptics.button();
                    context
                        .read<SettingsController>()
                        .clearCustomBackgroundImage();
                  },
                  child: Text(l10n.appWallpaperClearImage),
                ),
            ],
          ),
        ],
        if (kind == AppBackgroundKind.gradient) ...<Widget>[
          const SizedBox(height: 16),
          Text(
            l10n.appWallpaperStaticPresetsLabel,
            style: theme.textTheme.labelLarge?.copyWith(
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          _WallpaperPresetRow(
            ids: AppBackgroundPresets.staticPresetIds,
            selectedId: AppBackgroundPresets.resolveStaticPresetId(
              settings.appBackgroundPresetId,
            ),
            onSelect: (String id) => context
                .read<SettingsController>()
                .setAppBackgroundGradient(id),
          ),
        ],
        if (kind == AppBackgroundKind.gradientAnimated) ...<Widget>[
          const SizedBox(height: 16),
          Text(
            l10n.appWallpaperAnimatedPresetsLabel,
            style: theme.textTheme.labelLarge?.copyWith(
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          _WallpaperPresetRow(
            ids: AppBackgroundPresets.animatedPresetIds,
            selectedId: AppBackgroundPresets.resolveAnimatedPresetId(
              settings.appBackgroundPresetId,
            ),
            onSelect: (String id) => context
                .read<SettingsController>()
                .setAppBackgroundAnimated(id),
          ),
        ],
      ],
    );
  }
}

class _WallpaperPresetRow extends StatelessWidget {
  const _WallpaperPresetRow({
    required this.ids,
    required this.selectedId,
    required this.onSelect,
  });

  final List<String> ids;
  final String selectedId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: ids.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int i) {
          final String id = ids[i];
          final bool selected = id == selectedId;
          return _WallpaperPresetChip(
            label: id.wallpaperPresetLabel(l10n),
            selected: selected,
            onTap: () => onSelect(id),
          );
        },
      ),
    );
  }
}

class _WallpaperPresetChip extends StatelessWidget {
  const _WallpaperPresetChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Color bg = selected
        ? cs.primaryContainer
        : cs.surfaceContainerHighest;
    final Color fg =
        selected ? cs.onPrimaryContainer : cs.onSurfaceVariant;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          JobTrackHaptics.button();
          onTap();
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Text(
            label,
            style: textTheme.labelLarge?.copyWith(
              color: fg,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _FollowUpDaysSlider extends StatefulWidget {
  const _FollowUpDaysSlider();

  @override
  State<_FollowUpDaysSlider> createState() => _FollowUpDaysSliderState();
}

class _FollowUpDaysSliderState extends State<_FollowUpDaysSlider> {
  late int _draft;

  @override
  void initState() {
    super.initState();
    _draft = context.read<SettingsController>().waitingFollowUpDays;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Row(
      children: [
        Text(
          '$_draft',
          style: theme.textTheme.titleMedium?.copyWith(
            color: cs.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Slider(
            min: 3,
            max: 30,
            divisions: 27,
            label: '$_draft',
            value: _draft.toDouble(),
            onChanged: (double v) {
              final int next = v.round();
              if (next != _draft) {
                JobTrackHaptics.selection();
              }
              setState(() => _draft = next);
            },
            onChangeEnd: (double v) {
              context.read<SettingsController>().setWaitingFollowUpDays(
                    v.round(),
                  );
            },
          ),
        ),
      ],
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 10),
            child: Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                color: cs.onSurface,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: cs.surfaceContainerLow,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _PillRow<T> extends StatelessWidget {
  const _PillRow({
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
          _SelectPill(
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

class _SelectPill extends StatelessWidget {
  const _SelectPill({
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
