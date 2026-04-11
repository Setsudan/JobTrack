import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';

import 'package:job_application_tracker/core/profile/profile_models.dart';
import 'package:job_application_tracker/features/profile/share_temp_png.dart';
import 'package:job_application_tracker/features/profile/widgets/profile_business_card.dart';
import 'package:job_application_tracker/l10n/app_localizations.dart';

Future<void> shareProfileBusinessCard({
  required BuildContext context,
  required UserProfile profile,
  required AppLocalizations l10n,
  required String shareSubject,
}) async {
  if (!profileHasShareableContent(profile)) {
    return;
  }

  final overlayState = Overlay.maybeOf(context);
  if (overlayState == null) {
    return;
  }

  final theme = Theme.of(context);
  final boundaryKey = GlobalKey();
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (BuildContext ctx) {
      return Positioned(
        left: 0,
        top: 0,
        child: Material(
          color: Colors.transparent,
          child: Theme(
            data: theme,
            child: RepaintBoundary(
              key: boundaryKey,
              child: SizedBox(
                width: 900,
                height: 500,
                child: ProfileBusinessCard(
                  profile: profile,
                  l10n: l10n,
                  colorScheme: theme.colorScheme,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );

  overlayState.insert(entry);

  await Future<void>.delayed(Duration.zero);
  await WidgetsBinding.instance.endOfFrame;

  try {
    final boundary = boundaryKey.currentContext?.findRenderObject();
    if (boundary is! RenderRepaintBoundary) {
      return;
    }

    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      return;
    }
    final bytes = byteData.buffer.asUint8List();

    if (!context.mounted) {
      return;
    }

    if (kIsWeb) {
      await SharePlus.instance.share(
        ShareParams(
          files: <XFile>[
            XFile.fromData(
              bytes,
              name: 'jobtrack_profile_card.png',
              mimeType: 'image/png',
            ),
          ],
          subject: shareSubject,
          text: shareSubject,
        ),
      );
    } else {
      final path = await writeTempProfilePng(bytes);
      if (path.isEmpty) {
        return;
      }
      await SharePlus.instance.share(
        ShareParams(
          files: <XFile>[XFile(path, mimeType: 'image/png')],
          subject: shareSubject,
          text: shareSubject,
        ),
      );
    }
  } finally {
    entry.remove();
  }
}
