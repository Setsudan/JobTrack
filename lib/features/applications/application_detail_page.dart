import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:job_application_tracker/core/applications/applications_controller.dart';
import 'package:job_application_tracker/features/applications/application_detail_delete.dart';
import 'package:job_application_tracker/features/applications/application_detail_editor.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

class ApplicationDetailPage extends StatelessWidget {
  const ApplicationDetailPage({required this.applicationId, super.key});

  final String applicationId;

  @override
  Widget build(BuildContext context) {
    context.select<ApplicationsController, int>((ApplicationsController c) {
      return c.changeSignatureForId(applicationId);
    });
    final l10n = context.l10n;
    final ApplicationsController apps = context.read<ApplicationsController>();
    if (apps.byId(applicationId) == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.applicationDetailTitle)),
        body: const SizedBox.shrink(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.applicationDetailTitle),
        actions: [
          IconButton(
            tooltip: l10n.applicationDelete,
            onPressed: () =>
                confirmAndDeleteApplication(context, applicationId),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: ApplicationDetailEditor(applicationId: applicationId),
    );
  }
}
