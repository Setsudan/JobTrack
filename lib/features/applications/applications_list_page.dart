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
import 'package:job_application_tracker/core/widgets/select_pill_row.dart';
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

  List<JobApplication> _applyCsvResolvedDates(
    CsvImportResult parsed,
    DateTime resolved,
  ) {
    final DateTime fill = JobApplication.dateOnly(resolved);
    return List<JobApplication>.generate(parsed.applications.length, (int i) {
      final JobApplication a = parsed.applications[i];
      if (parsed.hadSubmittedOnFromCsv[i]) {
        return a;
      }
      return a.copyWith(submittedOn: fill);
    });
  }

  Future<DateTime?> _promptCsvMissingDateChoice(int missingCount) async {
    final l10n = context.l10n;
    return showDialog<DateTime?>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(l10n.csvImportMissingDateTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(l10n.csvImportMissingDateBody(missingCount)),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  JobTrackHaptics.button();
                  Navigator.pop(
                    dialogContext,
                    JobApplication.dateOnly(DateTime.now()),
                  );
                },
                child: Text(l10n.csvImportMissingDateUseToday),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () async {
                  JobTrackHaptics.button();
                  final DateTime? picked = await showDatePicker(
                    context: dialogContext,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (!dialogContext.mounted) {
                    return;
                  }
                  if (picked != null) {
                    Navigator.pop(
                      dialogContext,
                      JobApplication.dateOnly(picked),
                    );
                  }
                },
                child: Text(l10n.csvImportMissingDatePickDate),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                JobTrackHaptics.button();
                Navigator.pop(dialogContext);
              },
              child: Text(l10n.commonCancel),
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
    List<JobApplication> toImport = parsed.applications;
    if (parsed.hasAnyMissingCsvDate) {
      final int missing = parsed.hadSubmittedOnFromCsv
          .where((bool had) => !had)
          .length;
      final DateTime? choice = await _promptCsvMissingDateChoice(missing);
      if (!mounted) {
        return;
      }
      if (choice == null) {
        return;
      }
      toImport = _applyCsvResolvedDates(parsed, choice);
    }
    await context.read<ApplicationsController>().importApplications(toImport);
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: DualSegmentPill(
                value: _showArchived,
                onSelected: (bool v) {
                  setState(() => _showArchived = v);
                },
                firstLabel: l10n.applicationsActiveTab,
                secondLabel: l10n.applicationsArchivedTab,
              ),
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

                      final bool startSwipeUseful = startSwipeWouldChangeStatus(
                        swipeParts[0],
                        a.status,
                      );
                      final bool endSwipeUseful = endSwipeWouldChangeStatus(
                        swipeParts[1],
                        a.status,
                      );
                      if (!startSwipeUseful && !endSwipeUseful) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: card,
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Slidable(
                          key: ValueKey<String>(a.id),
                          startActionPane: startSwipeUseful
                              ? ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: 0.32,
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext ctx) {
                                        _applyStartSwipe(ctx, a);
                                      },
                                      backgroundColor:
                                          theme.colorScheme.primaryContainer,
                                      foregroundColor: theme
                                          .colorScheme.onPrimaryContainer,
                                      icon: Icons.trending_up,
                                      label: startLabel,
                                    ),
                                  ],
                                )
                              : null,
                          endActionPane: endSwipeUseful
                              ? ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: 0.32,
                                  children: [
                                    SlidableAction(
                                      onPressed: (BuildContext ctx) {
                                        _applyEndSwipe(ctx, a);
                                      },
                                      backgroundColor:
                                          theme.colorScheme.errorContainer,
                                      foregroundColor: theme
                                          .colorScheme.onErrorContainer,
                                      icon: Icons.flag_outlined,
                                      label: endLabel,
                                    ),
                                  ],
                                )
                              : null,
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
