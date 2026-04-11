import 'package:flutter/material.dart';

import 'package:job_application_tracker/core/models/job_application.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

String _titleLine(JobApplication a, AppLocalizations l10n) {
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

String _companyLine(JobApplication a) {
  final c = a.companyName.trim();
  if (c.isNotEmpty) {
    return c;
  }
  return '';
}

class ApplicationArchiveReminderPage extends StatelessWidget {
  const ApplicationArchiveReminderPage({
    required this.waitingApplications,
    super.key,
  });

  final List<JobApplication> waitingApplications;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.archiveReminderTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
        children: [
          Text(l10n.archiveReminderBody, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 20),
          if (waitingApplications.isEmpty)
            Text(
              l10n.archiveReminderEmptyList,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            )
          else
            ...waitingApplications.map(
              (JobApplication a) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  title: Text(_titleLine(a, l10n)),
                  subtitle: _companyLine(a).isEmpty
                      ? null
                      : Text(_companyLine(a)),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 8, 20, 16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(l10n.commonCancel),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(l10n.archiveConfirmArchive),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
