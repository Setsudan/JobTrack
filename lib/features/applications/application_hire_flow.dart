import 'package:confetti/confetti.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:job_application_tracker/core/interaction/job_track_haptics.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

enum HireWizardOutcome { cancelled, huntOngoing, huntOverKeep, huntOverArchive }

Future<HireWizardOutcome> runHireWizard(BuildContext context) async {
  final l10n = context.l10n;
  final huntDone = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return AlertDialog(
        title: Text(l10n.hireAskJobHuntDoneTitle),
        content: Text(l10n.hireAskJobHuntDoneBody),
        actions: [
          TextButton(
            onPressed: () {
              JobTrackHaptics.button();
              Navigator.pop(ctx, false);
            },
            child: Text(l10n.hireJobHuntDoneNo),
          ),
          FilledButton(
            onPressed: () {
              JobTrackHaptics.button();
              Navigator.pop(ctx, true);
            },
            child: Text(l10n.hireJobHuntDoneYes),
          ),
        ],
      );
    },
  );
  if (!context.mounted) {
    return HireWizardOutcome.cancelled;
  }
  if (huntDone == null) {
    return HireWizardOutcome.cancelled;
  }
  if (!huntDone) {
    return HireWizardOutcome.huntOngoing;
  }

  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => const _HireConfettiCelebrationDialog(),
  );
  if (!context.mounted) {
    return HireWizardOutcome.cancelled;
  }

  final archiveOthers = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return AlertDialog(
        title: Text(l10n.hireAskDisposalTitle),
        content: Text(l10n.hireAskDisposalBody),
        actions: [
          TextButton(
            onPressed: () {
              JobTrackHaptics.button();
              Navigator.pop(ctx, false);
            },
            child: Text(l10n.hireKeepApplications),
          ),
          FilledButton(
            onPressed: () {
              JobTrackHaptics.button();
              Navigator.pop(ctx, true);
            },
            child: Text(l10n.hireArchiveApplications),
          ),
        ],
      );
    },
  );
  if (!context.mounted) {
    return HireWizardOutcome.cancelled;
  }
  if (archiveOthers == null) {
    return HireWizardOutcome.cancelled;
  }
  if (archiveOthers) {
    return HireWizardOutcome.huntOverArchive;
  }
  return HireWizardOutcome.huntOverKeep;
}

class _HireConfettiCelebrationDialog extends StatefulWidget {
  const _HireConfettiCelebrationDialog();

  @override
  State<_HireConfettiCelebrationDialog> createState() =>
      _HireConfettiCelebrationDialogState();
}

class _HireConfettiCelebrationDialogState
    extends State<_HireConfettiCelebrationDialog> {
  late final ConfettiController _controller = ConfettiController(
    duration: const Duration(seconds: 3),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: ConfettiWidget(
              confettiController: _controller,
              blastDirectionality: BlastDirectionality.explosive,
              blastDirection: math.pi / 2,
              shouldLoop: false,
              numberOfParticles: 22,
              maxBlastForce: 28,
              minBlastForce: 9,
              gravity: 0.22,
              colors: <Color>[
                scheme.primary,
                scheme.secondary,
                scheme.tertiary,
                scheme.primaryContainer,
                scheme.secondaryContainer,
              ],
            ),
          ),
          Material(
            color: scheme.surfaceContainerHigh,
            elevation: 3,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.hireCongratulationsTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.hireCongratulationsBody,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      JobTrackHaptics.button();
                      Navigator.pop(context);
                    },
                    child: Text(l10n.commonOk),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
