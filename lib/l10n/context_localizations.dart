import 'package:flutter/widgets.dart';

import 'package:job_application_tracker/l10n/app_localizations.dart';

extension ContextLocalizations on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
