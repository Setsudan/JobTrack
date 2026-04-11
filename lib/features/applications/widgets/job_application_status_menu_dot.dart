import 'package:flutter/material.dart';

import 'package:job_application_tracker/core/models/job_application_status.dart';
import 'package:job_application_tracker/core/theme/job_application_status_color_scheme.dart';

class JobApplicationStatusMenuDot extends StatelessWidget {
  const JobApplicationStatusMenuDot({required this.status, super.key});

  final JobApplicationStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tones = status.chipTones(Theme.of(context).brightness);
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: tones.background,
        shape: BoxShape.circle,
        border: Border.all(color: scheme.outline.withValues(alpha: 0.35)),
      ),
    );
  }
}
