import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

import 'package:job_application_tracker/core/interaction/job_track_haptics.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

class WallpaperCropPage extends StatefulWidget {
  const WallpaperCropPage({
    super.key,
    required this.imageBytes,
    required this.cropAspectRatio,
  });

  final Uint8List imageBytes;
  final double cropAspectRatio;

  @override
  State<WallpaperCropPage> createState() => _WallpaperCropPageState();
}

class _WallpaperCropPageState extends State<WallpaperCropPage> {
  final CropController _cropController = CropController();
  bool _cropping = false;

  void _onCropped(CropResult result) {
    if (!mounted) {
      return;
    }
    setState(() => _cropping = false);
    switch (result) {
      case CropSuccess(:final croppedImage):
        Navigator.of(context).pop<Uint8List>(croppedImage);
      case CropFailure():
        final messenger = ScaffoldMessenger.maybeOf(context);
        messenger?.showSnackBar(
          SnackBar(content: Text(context.l10n.appWallpaperCropFailed)),
        );
    }
  }

  void _requestCrop() {
    if (_cropping) {
      return;
    }
    JobTrackHaptics.button();
    setState(() => _cropping = true);
    _cropController.crop();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = context.l10n;
    final double ratio = widget.cropAspectRatio.isFinite &&
            widget.cropAspectRatio > 0.02
        ? widget.cropAspectRatio
        : 9 / 16;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(l10n.appWallpaperCropTitle),
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: l10n.commonCancel,
          onPressed: () {
            JobTrackHaptics.button();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Text(
              l10n.appWallpaperCropHint,
              style: theme.textTheme.bodySmall?.copyWith(
                color: cs.onSurfaceVariant,
                height: 1.35,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Crop(
                  image: widget.imageBytes,
                  controller: _cropController,
                  onCropped: _onCropped,
                  aspectRatio: ratio,
                  interactive: true,
                  fixCropRect: true,
                  baseColor: cs.surfaceContainerLow,
                  maskColor: Colors.black.withValues(alpha: 0.52),
                  radius: 12,
                  initialRectBuilder: InitialRectBuilder.withSizeAndRatio(
                    size: 1,
                    aspectRatio: ratio,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: FilledButton(
              onPressed: _cropping ? null : _requestCrop,
              child: _cropping
                  ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: cs.onPrimary,
                      ),
                    )
                  : Text(l10n.appWallpaperCropApply),
            ),
          ),
        ],
      ),
    );
  }
}
