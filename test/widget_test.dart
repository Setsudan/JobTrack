import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

import 'package:job_application_tracker/app/job_track_app.dart';
import 'package:job_application_tracker/core/applications/applications_controller.dart';
import 'package:job_application_tracker/core/profile/profile_controller.dart';
import 'package:job_application_tracker/core/settings/settings_controller.dart';
import 'package:job_application_tracker/data/isar/isar_schemas.dart';
import 'package:job_application_tracker/features/shell/app_navigation_bridge.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

import 'isar_test_support.dart';

void main() {
  testWidgets('AppShell shows localized home and profile (en)', (
    WidgetTester tester,
  ) async {
    late EphemeralIsar h;
    late String backgroundsPath;
    late ProfileController profileController;
    late ApplicationsController applicationsController;
    await tester.runAsync(() async {
      h = await openEphemeralJobTrackIsar();
      backgroundsPath = p.join(h.dir.path, 'backgrounds');
      await Directory(backgroundsPath).create(recursive: true);
      profileController = ProfileController(h.isar);
      await profileController.init();
      applicationsController = ApplicationsController(h.isar);
      await applicationsController.init();
    });
    addTearDown(() async {
      await closeEphemeralIsar(h.isar, h.dir);
    });

    final en = AppLocalizationsEn();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<SettingsController>(
            create: (_) => SettingsController(
              h.isar,
              backgroundsDirectoryPath: backgroundsPath,
            ),
          ),
          ChangeNotifierProvider<ProfileController>.value(
            value: profileController,
          ),
          ChangeNotifierProvider<ApplicationsController>.value(
            value: applicationsController,
          ),
          ChangeNotifierProvider<AppNavigationBridge>(
            create: (_) => AppNavigationBridge(),
          ),
        ],
        child: const JobTrackApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text(en.homeStatActiveTitle), findsOneWidget);

    Provider.of<AppNavigationBridge>(
      tester.element(find.byType(MaterialApp)),
      listen: false,
    ).setTab(3);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text(en.labelProfileDisplayName), findsOneWidget);

    await tester.tap(find.byTooltip(en.settingsTitle));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text(en.sectionAppearance), findsOneWidget);
    expect(find.text(en.labelBackground), findsOneWidget);
    expect(find.text(en.foundationBlurb), findsOneWidget);
  });

  testWidgets('AppShell shows localized profile strings (fr)', (
    WidgetTester tester,
  ) async {
    late EphemeralIsar h;
    late String backgroundsPath;
    late ProfileController profileController;
    late ApplicationsController applicationsController;
    await tester.runAsync(() async {
      h = await openEphemeralJobTrackIsar();
      backgroundsPath = p.join(h.dir.path, 'backgrounds');
      await Directory(backgroundsPath).create(recursive: true);
      final AppSettingsEntity? settingsRow =
          h.isar.appSettingsEntitys.getByRowKeySync(kSingletonSettings);
      if (settingsRow != null) {
        settingsRow.languageCode = 'fr';
        await h.isar.writeTxn(() async {
          await h.isar.appSettingsEntitys.put(settingsRow);
        });
      }
      profileController = ProfileController(h.isar);
      await profileController.init();
      applicationsController = ApplicationsController(h.isar);
      await applicationsController.init();
    });
    addTearDown(() async {
      await closeEphemeralIsar(h.isar, h.dir);
    });

    final fr = AppLocalizationsFr();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<SettingsController>(
            create: (_) => SettingsController(
              h.isar,
              backgroundsDirectoryPath: backgroundsPath,
            ),
          ),
          ChangeNotifierProvider<ProfileController>.value(
            value: profileController,
          ),
          ChangeNotifierProvider<ApplicationsController>.value(
            value: applicationsController,
          ),
          ChangeNotifierProvider<AppNavigationBridge>(
            create: (_) => AppNavigationBridge(),
          ),
        ],
        child: const JobTrackApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    Provider.of<AppNavigationBridge>(
      tester.element(find.byType(MaterialApp)),
      listen: false,
    ).setTab(3);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text(fr.labelProfileDisplayName), findsOneWidget);

    await tester.tap(find.byTooltip(fr.settingsTitle));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text(fr.sectionAppearance), findsOneWidget);
    expect(find.text(fr.labelBackground), findsOneWidget);
    expect(find.text(fr.foundationBlurb), findsOneWidget);
  });

  testWidgets('Applications tab shows empty list copy (en)', (
    WidgetTester tester,
  ) async {
    late EphemeralIsar h;
    late String backgroundsPath;
    late ProfileController profileController;
    late ApplicationsController applicationsController;
    await tester.runAsync(() async {
      h = await openEphemeralJobTrackIsar();
      backgroundsPath = p.join(h.dir.path, 'backgrounds');
      await Directory(backgroundsPath).create(recursive: true);
      profileController = ProfileController(h.isar);
      await profileController.init();
      applicationsController = ApplicationsController(h.isar);
      await applicationsController.init();
    });
    addTearDown(() async {
      await closeEphemeralIsar(h.isar, h.dir);
    });

    final en = AppLocalizationsEn();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<SettingsController>(
            create: (_) => SettingsController(
              h.isar,
              backgroundsDirectoryPath: backgroundsPath,
            ),
          ),
          ChangeNotifierProvider<ProfileController>.value(
            value: profileController,
          ),
          ChangeNotifierProvider<ApplicationsController>.value(
            value: applicationsController,
          ),
          ChangeNotifierProvider<AppNavigationBridge>(
            create: (_) => AppNavigationBridge(),
          ),
        ],
        child: const JobTrackApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    Provider.of<AppNavigationBridge>(
      tester.element(find.byType(MaterialApp)),
      listen: false,
    ).setTab(1);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text(en.applicationsEmptyActive), findsOneWidget);
  });
}
