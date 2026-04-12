import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:job_application_tracker/core/applications/applications_controller.dart';
import 'package:job_application_tracker/core/interaction/job_track_haptics.dart';
import 'package:job_application_tracker/core/applications/job_applications_csv_import.dart';
import 'package:job_application_tracker/core/applications/swipe_status_actions.dart';
import 'package:job_application_tracker/core/models/job_application.dart';
import 'package:job_application_tracker/core/models/job_application_status.dart';
import 'package:job_application_tracker/core/settings/settings_controller.dart';
import 'package:job_application_tracker/features/applications/application_detail_sheet.dart';
import 'package:job_application_tracker/features/applications/widgets/job_application_status_chip.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

class ApplicationsListPage extends StatefulWidget {
  const ApplicationsListPage({super.key});

  @override
  State<ApplicationsListPage> createState() => _ApplicationsListPageState();
}

class _ApplicationsListPageState extends State<ApplicationsListPage> {
  bool _showArchived = false;
  DateFormat? _dateFormat;

  String _primaryLine(JobApplication a, AppLocalizations l10n) {
    final t = a.jobTitle.trim();
    if (t.isNotEmpty) {
      return t;
    }
    final host = Uri.tryParse(a.postingUrl)?.host ?? '';
    if (host.isNotEmpty) {
      return host;
    }
    return l10n.labelJobPostingUrl;
  }

  String? _companyLine(JobApplication a) {
    final c = a.companyName.trim();
    if (c.isEmpty) {
      return null;
    }
    return c;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String loc = Localizations.localeOf(context).toString();
    _dateFormat = DateFormat.yMMMd(loc);
  }

  String _swipeDropdownLabel(BuildContext context, String value) {
    final l10n = context.l10n;
    if (value == swipeActionAdvanceStorageValue) {
      return l10n.swipeShortcutAdvanceLabel;
    }
    try {
      return JobApplicationStatus.values.byName(value).localize(l10n);
    } catch (_) {
      return value;
    }
  }

  Future<void> _applyStartSwipe(
    BuildContext context,
    JobApplication application,
  ) async {
    final settings = context.read<SettingsController>();
    final apps = context.read<ApplicationsController>();
    final live = apps.byId(application.id);
    if (live == null) {
      return;
    }
    final next = resolveStartPaneSwipeTarget(
      settings.swipeStartPaneAction,
      live.status,
    );
    if (next == live.status) {
      JobTrackHaptics.button();
      Slidable.of(context)?.close();
      return;
    }
    JobTrackHaptics.action();
    await apps.update(live.copyWith(status: next));
    if (context.mounted) {
      Slidable.of(context)?.close();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l10n.applicationSwipeStatusUpdated(next.localize(context.l10n)),
          ),
        ),
      );
    }
  }

  Future<void> _applyEndSwipe(
    BuildContext context,
    JobApplication application,
  ) async {
    final settings = context.read<SettingsController>();
    final apps = context.read<ApplicationsController>();
    final live = apps.byId(application.id);
    if (live == null) {
      return;
    }
    final next = resolveEndPaneSwipeTarget(
      settings.swipeEndPaneAction,
      live.status,
    );
    if (next == live.status) {
      JobTrackHaptics.button();
      Slidable.of(context)?.close();
      return;
    }
    JobTrackHaptics.action();
    await apps.update(live.copyWith(status: next));
    if (context.mounted) {
      Slidable.of(context)?.close();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l10n.applicationSwipeStatusUpdated(next.localize(context.l10n)),
          ),
        ),
      );
    }
  }

  Future<void> _showCsvHelpDialog() async {
    final l10n = context.l10n;
    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(l10n.csvImportHelpTitle),
          content: SingleChildScrollView(
            child: Text(l10n.csvImportHelpBody),
          ),
          actions: [
            TextButton(
              onPressed: () {
                JobTrackHaptics.button();
                Navigator.pop(ctx);
              },
              child: Text(l10n.commonOk),
            ),
          ],
        );
      },
    );
  }

  Future<void> _importCsvFromPicker() async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: <String>['csv'],
      withData: true,
    );
    if (!mounted) {
      return;
    }
    if (result == null || result.files.isEmpty) {
      return;
    }
    final file = result.files.first;
    if (file.bytes == null) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.csvImportParseFailed)));
      return;
    }
    final text = utf8.decode(file.bytes!);
    final parsed = parseJobApplicationsCsv(text);
    if (parsed.errorMessages.contains('parse_error')) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.csvImportParseFailed)));
      return;
    }
    if (parsed.errorMessages.contains('missing_headers')) {
      await showDialog<void>(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(l10n.csvImportTitle),
            content: Text(l10n.csvImportMissingHeaders),
            actions: [
              TextButton(
                onPressed: () {
                  JobTrackHaptics.button();
                  Navigator.pop(ctx);
                },
                child: Text(l10n.commonOk),
              ),
            ],
          );
        },
      );
      return;
    }
    if (parsed.applications.isEmpty) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.csvImportNoRows)));
      return;
    }
    await context.read<ApplicationsController>().importApplications(
      parsed.applications,
    );
    if (!mounted) {
      return;
    }
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          l10n.csvImportSummary(
            parsed.applications.length,
            parsed.skippedCount,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.select<ApplicationsController, int>((ApplicationsController c) {
      return c.changeSignature;
    });
    final String swipePair = context.select<SettingsController, String>(
      (SettingsController s) =>
          '${s.swipeStartPaneAction}\x1F${s.swipeEndPaneAction}',
    );
    final List<String> swipeParts = swipePair.split('\x1F');
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final ApplicationsController apps = context.read<ApplicationsController>();
    final String startLabel = _swipeDropdownLabel(context, swipeParts[0]);
    final String endLabel = _swipeDropdownLabel(context, swipeParts[1]);
    final source = _showArchived
        ? apps.archivedApplications()
        : apps.activeApplications();
    final sorted = List<JobApplication>.of(source)
      ..sort((a, b) => b.submittedOn.compareTo(a.submittedOn));

    final DateFormat df = _dateFormat ?? DateFormat.yMMMd('en');

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.applicationsListTitle),
        actions: [
          PopupMenuButton<String>(
            tooltip: l10n.applicationsListMenuTooltip,
            onSelected: (String value) async {
              JobTrackHaptics.selection();
              if (value == 'import') {
                await _importCsvFromPicker();
              } else if (value == 'help') {
                await _showCsvHelpDialog();
              }
            },
            itemBuilder: (BuildContext ctx) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'import',
                  child: Text(l10n.applicationsMenuImportCsv),
                ),
                PopupMenuItem<String>(
                  value: 'help',
                  child: Text(l10n.csvImportHelpTitle),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  selected: !_showArchived,
                  label: Text(l10n.applicationsActiveTab),
                  onSelected: (_) {
                    JobTrackHaptics.selection();
                    setState(() => _showArchived = false);
                  },
                ),
                FilterChip(
                  selected: _showArchived,
                  label: Text(l10n.applicationsArchivedTab),
                  onSelected: (_) {
                    JobTrackHaptics.selection();
                    setState(() => _showArchived = true);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: sorted.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        _showArchived
                            ? l10n.applicationsEmptyArchived
                            : l10n.applicationsEmptyActive,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                    itemCount: sorted.length,
                    itemBuilder: (BuildContext context, int index) {
                      final a = sorted[index];
                      final company = _companyLine(a);
                      final card = Card(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            JobTrackHaptics.button();
                            showApplicationDetailSheet(context, a.id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _primaryLine(a, l10n),
                                        style: theme.textTheme.titleMedium,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    JobApplicationStatusChip(status: a.status),
                                  ],
                                ),
                                if (company != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    company,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 6),
                                Text(
                                  df.format(a.submittedOn),
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: theme.colorScheme.outline,
                                  ),
                                ),
                                if (_showArchived &&
                                    (a.archiveGroupLabel ?? '').isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    a.archiveGroupLabel!,
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );

                      if (_showArchived) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: card,
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Slidable(
                          key: ValueKey<String>(a.id),
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.32,
                            children: [
                              SlidableAction(
                                onPressed: (BuildContext ctx) {
                                  _applyStartSwipe(ctx, a);
                                },
                                backgroundColor:
                                    theme.colorScheme.primaryContainer,
                                foregroundColor:
                                    theme.colorScheme.onPrimaryContainer,
                                icon: Icons.trending_up,
                                label: startLabel,
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.32,
                            children: [
                              SlidableAction(
                                onPressed: (BuildContext ctx) {
                                  _applyEndSwipe(ctx, a);
                                },
                                backgroundColor:
                                    theme.colorScheme.errorContainer,
                                foregroundColor:
                                    theme.colorScheme.onErrorContainer,
                                icon: Icons.flag_outlined,
                                label: endLabel,
                              ),
                            ],
                          ),
                          child: card,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
