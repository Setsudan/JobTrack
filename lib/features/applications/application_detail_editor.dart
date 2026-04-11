import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:job_application_tracker/core/applications/application_archive_label.dart';
import 'package:job_application_tracker/core/applications/applications_controller.dart';
import 'package:job_application_tracker/core/applications/job_posting_metadata_service.dart';
import 'package:job_application_tracker/core/models/job_application.dart';
import 'package:job_application_tracker/core/models/job_application_status.dart';
import 'package:job_application_tracker/core/profile/profile_models.dart';
import 'package:job_application_tracker/features/applications/application_archive_reminder_page.dart';
import 'package:job_application_tracker/features/applications/application_hire_flow.dart';
import 'package:job_application_tracker/features/applications/archive_label_format.dart';
import 'package:job_application_tracker/features/applications/widgets/job_application_status_menu_dot.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

class ApplicationDetailEditor extends StatefulWidget {
  const ApplicationDetailEditor({
    required this.applicationId,
    super.key,
    this.scrollController,
    this.listPrefix = const <Widget>[],
  });

  final String applicationId;
  final ScrollController? scrollController;
  final List<Widget> listPrefix;

  @override
  State<ApplicationDetailEditor> createState() =>
      _ApplicationDetailEditorState();
}

class _ApplicationDetailEditorState extends State<ApplicationDetailEditor> {
  late final TextEditingController _urlController;
  late final TextEditingController _titleController;
  late final TextEditingController _companyController;
  late final JobPostingMetadataService _metadataService;
  late final ScrollController _ownedScrollController;
  ScrollController get _effectiveScroll =>
      widget.scrollController ?? _ownedScrollController;

  JobApplicationStatus _status = JobApplicationStatus.submitted;
  DateTime _submittedOn = JobApplication.dateOnly(DateTime.now());
  bool _fetchingMeta = false;
  bool _ownController = false;

  @override
  void initState() {
    super.initState();
    _metadataService = JobPostingMetadataService();
    _ownController = widget.scrollController == null;
    _ownedScrollController = ScrollController();
    final apps = context.read<ApplicationsController>();
    final app = apps.byId(widget.applicationId);
    if (app == null) {
      _urlController = TextEditingController();
      _titleController = TextEditingController();
      _companyController = TextEditingController();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pop(context);
        }
      });
      return;
    }
    _urlController = TextEditingController(text: app.postingUrl);
    _titleController = TextEditingController(text: app.jobTitle);
    _companyController = TextEditingController(text: app.companyName);
    _status = app.status;
    _submittedOn = app.submittedOn;
  }

  @override
  void dispose() {
    _metadataService.dispose();
    _urlController.dispose();
    _titleController.dispose();
    _companyController.dispose();
    if (_ownController) {
      _ownedScrollController.dispose();
    }
    super.dispose();
  }

  Future<void> _pickSubmittedDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _submittedOn,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _submittedOn = JobApplication.dateOnly(picked));
    }
  }

  Future<void> _fetchMetadata() async {
    final l10n = context.l10n;
    final normalized = normalizeOptionalUrl(_urlController.text);
    if (normalized == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.profileInvalidUrl)));
      return;
    }
    setState(() => _fetchingMeta = true);
    final result = await _metadataService.fetchHints(normalized);
    if (!mounted) {
      return;
    }
    setState(() => _fetchingMeta = false);
    if (result.titleGuess != null && result.titleGuess!.trim().isNotEmpty) {
      _titleController.text = result.titleGuess!.trim();
    }
    if (result.companyGuess != null && result.companyGuess!.trim().isNotEmpty) {
      _companyController.text = result.companyGuess!.trim();
    }
    if ((result.titleGuess == null || result.titleGuess!.trim().isEmpty) &&
        (result.companyGuess == null || result.companyGuess!.trim().isEmpty)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.jobMetadataNothingFound)));
    }
  }

  Future<void> _openPosting() async {
    final l10n = context.l10n;
    final normalized = normalizeOptionalUrl(_urlController.text);
    if (normalized == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.profileInvalidUrl)));
      return;
    }
    final uri = Uri.tryParse(normalized);
    if (uri == null) {
      return;
    }
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.jobMetadataFetchFailed)));
    }
  }

  JobApplication? _buildDraft(JobApplication? previous) {
    final l10n = context.l10n;
    final normalized = normalizeOptionalUrl(_urlController.text);
    if (normalized == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.applicationUrlRequired)));
      return null;
    }
    if (previous == null) {
      return null;
    }
    return JobApplication(
      id: previous.id,
      postingUrl: normalized,
      jobTitle: _titleController.text.trim(),
      companyName: _companyController.text.trim(),
      submittedOn: _submittedOn,
      status: _status,
      isArchived: previous.isArchived,
      archiveGroupKey: previous.archiveGroupKey,
      archiveGroupLabel: previous.archiveGroupLabel,
    );
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final apps = context.read<ApplicationsController>();
    final previous = apps.byId(widget.applicationId);
    if (previous == null) {
      return;
    }
    final next = _buildDraft(previous);
    if (next == null) {
      return;
    }

    final becameHired =
        next.status == JobApplicationStatus.offerAccepted &&
        previous.status != JobApplicationStatus.offerAccepted;

    if (becameHired) {
      final flow = await runHireWizard(context);
      if (!mounted) {
        return;
      }
      if (flow == HireWizardOutcome.cancelled) {
        return;
      }
      await apps.update(next);
      if (!mounted) {
        return;
      }
      if (flow == HireWizardOutcome.huntOverArchive) {
        final now = DateTime.now();
        final others = apps.activeApplications().where((a) {
          return a.id != next.id;
        }).toList();
        final modeTitle = modeDisplayJobTitle(others.map((a) => a.jobTitle));
        final label = formatArchiveBundleLabel(l10n, modeTitle, now);
        final waiting = apps.decisionPendingActiveExcept(next.id);
        final confirmed = await Navigator.of(context).push<bool>(
          MaterialPageRoute<bool>(
            builder: (ctx) =>
                ApplicationArchiveReminderPage(waitingApplications: waiting),
          ),
        );
        if (!mounted) {
          return;
        }
        if (confirmed == true) {
          await apps.archiveAllActiveExcept(
            exceptId: next.id,
            at: now,
            groupLabel: label,
          );
        }
      }
    } else {
      await apps.update(next);
    }

    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.applicationSaved)));
  }

  @override
  Widget build(BuildContext context) {
    context.select<ApplicationsController, int>((ApplicationsController c) {
      return c.changeSignatureForId(widget.applicationId);
    });
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final ApplicationsController apps =
        context.read<ApplicationsController>();
    final JobApplication? live = apps.byId(widget.applicationId);
    if (live == null) {
      return const SizedBox.shrink();
    }

    final dateStr = DateFormat.yMMMd(
      Localizations.localeOf(context).toString(),
    ).format(_submittedOn);

    final fields = <Widget>[
      ...widget.listPrefix,
      TextField(
        controller: _urlController,
        decoration: InputDecoration(
          labelText: l10n.labelJobPostingUrl,
          hintText: l10n.hintJobPostingUrl,
        ),
        keyboardType: TextInputType.url,
        textInputAction: TextInputAction.next,
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _fetchingMeta ? null : _fetchMetadata,
              icon: _fetchingMeta
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.primary,
                      ),
                    )
                  : const Icon(Icons.link_outlined),
              label: Text(l10n.buttonFetchJobDetails),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton.tonalIcon(
              onPressed: _openPosting,
              icon: const Icon(Icons.open_in_new),
              label: Text(l10n.applicationOpenPosting),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      TextField(
        controller: _titleController,
        decoration: InputDecoration(labelText: l10n.labelJobTitle),
        textInputAction: TextInputAction.next,
      ),
      const SizedBox(height: 16),
      TextField(
        controller: _companyController,
        decoration: InputDecoration(labelText: l10n.labelCompanyName),
        textInputAction: TextInputAction.done,
      ),
      const SizedBox(height: 20),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          _status == JobApplicationStatus.draft
              ? l10n.labelReminderToApplyDate
              : l10n.labelDateSubmitted,
        ),
        subtitle: Text(dateStr),
        trailing: const Icon(Icons.calendar_today_outlined),
        onTap: _pickSubmittedDate,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      const SizedBox(height: 8),
      DropdownButtonFormField<JobApplicationStatus>(
        // ignore: deprecated_member_use
        value: _status,
        decoration: InputDecoration(labelText: l10n.labelApplicationStatus),
        items: JobApplicationStatus.values
            .map(
              (JobApplicationStatus s) =>
                  DropdownMenuItem<JobApplicationStatus>(
                    value: s,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        JobApplicationStatusMenuDot(status: s),
                        const SizedBox(width: 10),
                        Text(s.localize(l10n)),
                      ],
                    ),
                  ),
            )
            .toList(),
        onChanged: (JobApplicationStatus? v) {
          if (v != null) {
            setState(() => _status = v);
          }
        },
      ),
      const SizedBox(height: 28),
      FilledButton(
        onPressed: _save,
        child: Text(l10n.buttonSaveApplication),
      ),
    ];

    return ListView(
      controller: _effectiveScroll,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      children: fields,
    );
  }
}
