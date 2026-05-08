import 'package:flutter/material.dart';

import 'package:job_application_tracker/core/interaction/job_track_haptics.dart';
import 'package:job_application_tracker/features/applications/application_detail_delete.dart';
import 'package:job_application_tracker/features/applications/application_detail_editor.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

Future<void> showApplicationDetailSheet(
  BuildContext context,
  String applicationId,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (sheetContext) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.72,
        minChildSize: 0.38,
        maxChildSize: 0.94,
        builder: (dragContext, scrollController) {
          final l10n = dragContext.l10n;
          return ApplicationDetailEditor(
            applicationId: applicationId,
            modalSheetHostContext: sheetContext,
            scrollController: scrollController,
            listPrefix: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        l10n.applicationDetailTitle,
                        style: Theme.of(dragContext).textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.commonClose,
                      onPressed: () {
                        JobTrackHaptics.button();
                        Navigator.of(sheetContext).pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                    PopupMenuButton<String>(
                      itemBuilder: (ctx) => [
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Text(l10n.applicationDelete),
                        ),
                      ],
                      onSelected: (String v) {
                        JobTrackHaptics.selection();
                        if (v == 'delete') {
                          confirmAndDeleteApplication(
                            dragContext,
                            applicationId,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
