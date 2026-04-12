import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:job_application_tracker/core/applications/applications_controller.dart';
import 'package:job_application_tracker/core/interaction/job_track_haptics.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

Future<void> confirmAndDeleteApplication(
  BuildContext context,
  String applicationId,
) async {
  final l10n = context.l10n;
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(l10n.applicationDeleteConfirmTitle),
        content: Text(l10n.applicationDeleteConfirmBody),
        actions: [
          TextButton(
            onPressed: () {
              JobTrackHaptics.button();
              Navigator.pop(ctx, false);
            },
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () {
              JobTrackHaptics.button();
              Navigator.pop(ctx, true);
            },
            child: Text(l10n.applicationConfirmDelete),
          ),
        ],
      );
    },
  );
  if (ok == true && context.mounted) {
    await context.read<ApplicationsController>().remove(applicationId);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
