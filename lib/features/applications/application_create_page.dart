import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:job_application_tracker/core/applications/application_archive_label.dart';
import 'package:job_application_tracker/core/applications/application_id.dart';
import 'package:job_application_tracker/core/applications/applications_controller.dart';
import 'package:job_application_tracker/core/applications/job_posting_metadata_service.dart';
import 'package:job_application_tracker/core/models/job_application.dart';
import 'package:job_application_tracker/core/models/job_application_status.dart';
import 'package:job_application_tracker/core/profile/profile_models.dart';
import 'package:job_application_tracker/features/applications/application_archive_reminder_page.dart';
import 'package:job_application_tracker/features/applications/application_detail_sheet.dart';
import 'package:job_application_tracker/features/applications/widgets/job_application_status_menu_dot.dart';
import 'package:job_application_tracker/features/applications/application_hire_flow.dart';
import 'package:job_application_tracker/features/applications/archive_label_format.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

class ApplicationCreatePage extends StatefulWidget {
  const ApplicationCreatePage({super.key});

  @override
  State<ApplicationCreatePage> createState() => _ApplicationCreatePageState();
}

class _ApplicationCreatePageState extends State<ApplicationCreatePage> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  late final JobPostingMetadataService _metadataService;
  JobApplicationStatus _status = JobApplicationStatus.submitted;
  DateTime _submittedOn = JobApplication.dateOnly(DateTime.now());
  bool _fetchingMeta = false;

  @override
  void initState() {
    super.initState();
    _metadataService = JobPostingMetadataService();
  }

  @override
  void dispose() {
    _metadataService.dispose();
    _urlController.dispose();
    _titleController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _urlController.clear();
    _titleController.clear();
    _companyController.clear();
    setState(() {
      _status = JobApplicationStatus.submitted;
      _submittedOn = JobApplication.dateOnly(DateTime.now());
    });
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

  JobApplication? _buildNewApplication(String id) {
    final l10n = context.l10n;
    final normalized = normalizeOptionalUrl(_urlController.text);
    if (normalized == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.applicationUrlRequired)));
      return null;
    }
    return JobApplication(
      id: id,
      postingUrl: normalized,
      jobTitle: _titleController.text.trim(),
      companyName: _companyController.text.trim(),
      submittedOn: _submittedOn,
      status: _status,
    );
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final apps = context.read<ApplicationsController>();
    final id = newJobApplicationId();
    final next = _buildNewApplication(id);
    if (next == null) {
      return;
    }

    final becameHired = next.status == JobApplicationStatus.offerAccepted;

    if (becameHired) {
      final flow = await runHireWizard(context);
      if (!mounted) {
        return;
      }
      if (flow == HireWizardOutcome.cancelled) {
        return;
      }
      await apps.add(next);
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
      await apps.add(next);
    }

    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.applicationSaved)));
    _resetForm();
    await showApplicationDetailSheet(context, next.id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final dateStr = DateFormat.yMMMd(
      Localizations.localeOf(context).toString(),
    ).format(_submittedOn);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.applicationCreateTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
        children: [
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
          OutlinedButton.icon(
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
        ],
      ),
    );
  }
}
