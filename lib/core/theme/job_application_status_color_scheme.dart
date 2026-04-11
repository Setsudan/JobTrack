import 'package:flutter/material.dart';

import 'package:job_application_tracker/core/models/job_application_status.dart';
import 'package:job_application_tracker/core/theme/job_track_palette.dart';

/// Status chip colors: fixed black / white / blue palette only (not theme accent).
extension JobApplicationStatusColorScheme on JobApplicationStatus {
  ({Color background, Color foreground}) chipTones(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    if (dark) {
      return switch (this) {
        JobApplicationStatus.draft => (
          background: JobTrackPalette.slate800,
          foreground: JobTrackPalette.blueGray200,
        ),
        JobApplicationStatus.submitted => (
          background: const Color(0xFF1E3A5F),
          foreground: JobTrackPalette.blueMid,
        ),
        JobApplicationStatus.noResponseYet => (
          background: JobTrackPalette.gray850,
          foreground: JobTrackPalette.gray400,
        ),
        JobApplicationStatus.interviewScheduled => (
          background: const Color(0xFF0D3D6E),
          foreground: JobTrackPalette.blueMid,
        ),
        JobApplicationStatus.decisionPending => (
          background: const Color(0xFF1565C0),
          foreground: Colors.white,
        ),
        JobApplicationStatus.closedNotSelected => (
          background: JobTrackPalette.gray800,
          foreground: JobTrackPalette.blueGray200,
        ),
        JobApplicationStatus.offerAccepted => (
          background: JobTrackPalette.blueDark,
          foreground: Colors.white,
        ),
      };
    }
    return switch (this) {
      JobApplicationStatus.draft => (
        background: JobTrackPalette.gray200,
        foreground: JobTrackPalette.slate700,
      ),
      JobApplicationStatus.submitted => (
        background: JobTrackPalette.blueLight,
        foreground: JobTrackPalette.blueOnLight,
      ),
      JobApplicationStatus.noResponseYet => (
        background: JobTrackPalette.gray50,
        foreground: JobTrackPalette.gray700,
      ),
      JobApplicationStatus.interviewScheduled => (
        background: JobTrackPalette.blueMid,
        foreground: JobTrackPalette.blueOnLight,
      ),
      JobApplicationStatus.decisionPending => (
        background: JobTrackPalette.blue,
        foreground: Colors.white,
      ),
      JobApplicationStatus.closedNotSelected => (
        background: JobTrackPalette.gray200,
        foreground: JobTrackPalette.gray600,
      ),
      JobApplicationStatus.offerAccepted => (
        background: JobTrackPalette.blue,
        foreground: Colors.white,
      ),
    };
  }
}
