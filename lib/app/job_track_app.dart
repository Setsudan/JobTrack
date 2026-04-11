import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:job_application_tracker/app/app_wallpaper.dart';
import 'package:job_application_tracker/core/settings/app_appearance.dart';
import 'package:job_application_tracker/core/settings/app_background_kind.dart';
import 'package:job_application_tracker/core/settings/settings_controller.dart';
import 'package:job_application_tracker/core/ui/gaussian_blur_filter.dart';
import 'package:job_application_tracker/core/theme/app_theme.dart';
import 'package:job_application_tracker/features/shell/app_shell.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

class JobTrackApp extends StatelessWidget {
  const JobTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsController>(
      builder: (context, settings, _) {
        final bool wallpaper = settings.wallpaperActive;
        final bool useGlobalBackdropBlur =
            wallpaper && settings.appBackgroundKind != AppBackgroundKind.image;
        final ThemeData light =
            wallpaper ? AppTheme.lightWithWallpaper() : AppTheme.light();
        final ThemeData dark =
            wallpaper
                ? (settings.appearance == AppAppearance.amoledBlack
                    ? AppTheme.amoledBlackWithWallpaper()
                    : AppTheme.darkWithWallpaper())
                : (settings.appearance == AppAppearance.amoledBlack
                    ? AppTheme.amoledBlack()
                    : AppTheme.dark());
        return MaterialApp(
          onGenerateTitle: (ctx) =>
              AppLocalizations.of(ctx)?.appTitle ??
              AppLocalizationsEn().appTitle,
          debugShowCheckedModeBanner: false,
          locale: settings.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: light,
          darkTheme: dark,
          themeMode: settings.themeMode,
          builder: (BuildContext context, Widget? child) {
            final Widget? c = child;
            if (c == null) {
              return const SizedBox.shrink();
            }
            final Widget chrome = useGlobalBackdropBlur
                ? RepaintBoundary(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: gaussianBlurFilter(sigmaX: 20, sigmaY: 20),
                        child: c,
                      ),
                    ),
                  )
                : c;
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                const AppWallpaper(),
                chrome,
              ],
            );
          },
          home: const AppShell(
            key: ValueKey<String>('AppShell_stateless_nav_bridge'),
          ),
        );
      },
    );
  }
}
