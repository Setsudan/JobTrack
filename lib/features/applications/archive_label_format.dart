import 'package:job_application_tracker/l10n/app_localizations.dart';

String formatArchiveBundleLabel(
  AppLocalizations l10n,
  String modeTitle,
  DateTime at,
) {
  final semester = at.month <= 6
      ? l10n.archiveSemesterFirstHalf
      : l10n.archiveSemesterSecondHalf;
  final title = modeTitle.trim().isEmpty
      ? l10n.archiveUntitledRole
      : modeTitle.trim();
  return l10n.archiveGroupDisplay(title, semester, at.year.toString());
}
