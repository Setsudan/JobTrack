import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:job_application_tracker/l10n/l10n.dart';

/// Shown when bootstrap in [main] fails before the normal app tree exists.
class StartupFailureApp extends StatelessWidget {
  const StartupFailureApp({
    super.key,
    required this.error,
    required this.stackTrace,
    required this.logFilePath,
  });

  final Object error;
  final StackTrace stackTrace;
  final String logFilePath;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (BuildContext ctx) => ctx.l10n.startupFailureTitle,
      home: Builder(
        builder: (BuildContext innerContext) {
          final AppLocalizations l10n = innerContext.l10n;
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ListView(
                  children: [
                    Text(
                      l10n.startupFailureTitle,
                      style: Theme.of(innerContext).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(l10n.startupFailureBody),
                    const SizedBox(height: 16),
                    Text(
                      l10n.startupFailureLogPathLabel,
                      style: Theme.of(innerContext).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    SelectableText(logFilePath),
                    const SizedBox(height: 24),
                    Text(
                      l10n.startupFailureTechnicalHint,
                      style: Theme.of(innerContext).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      kReleaseMode
                          ? '${error.runtimeType}: $error'
                          : '$error\n\n$stackTrace',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
