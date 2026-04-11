import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:job_application_tracker/core/applications/applications_controller.dart';
import 'package:job_application_tracker/core/models/job_application.dart';
import 'package:job_application_tracker/core/models/job_application_status.dart';
import 'package:job_application_tracker/features/home/home_page.dart';
import 'package:job_application_tracker/features/shell/app_navigation_bridge.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

import 'isar_test_support.dart';

void main() {
  testWidgets('Home stats grid shows expected counts (en)', (
    WidgetTester tester,
  ) async {
    late EphemeralIsar h;
    late ApplicationsController apps;
    await tester.runAsync(() async {
      h = await openEphemeralJobTrackIsar();
      apps = ApplicationsController(h.isar);
      await apps.init();
      await apps.add(
        JobApplication(
          id: 'a1',
          postingUrl: 'https://example.com/a1',
          jobTitle: 'Role A',
          companyName: 'Co',
          submittedOn: DateTime(2025, 1, 1),
          status: JobApplicationStatus.submitted,
        ),
      );
      await apps.add(
        JobApplication(
          id: 'a2',
          postingUrl: 'https://example.com/a2',
          jobTitle: 'Role B',
          companyName: 'Co',
          submittedOn: DateTime(2025, 1, 2),
          status: JobApplicationStatus.noResponseYet,
        ),
      );
      await apps.add(
        JobApplication(
          id: 'a3',
          postingUrl: 'https://example.com/a3',
          jobTitle: 'Role C',
          companyName: 'Co',
          submittedOn: DateTime(2025, 1, 3),
          status: JobApplicationStatus.interviewScheduled,
        ),
      );
      await apps.add(
        JobApplication(
          id: 'a4',
          postingUrl: 'https://example.com/a4',
          jobTitle: 'Role D',
          companyName: 'Co',
          submittedOn: DateTime(2025, 1, 4),
          status: JobApplicationStatus.draft,
        ),
      );
      await apps.add(
        JobApplication(
          id: 'a5',
          postingUrl: 'https://example.com/a5',
          jobTitle: 'Role E',
          companyName: 'Co',
          submittedOn: DateTime(2025, 1, 5),
          status: JobApplicationStatus.closedNotSelected,
          isArchived: true,
        ),
      );
    });
    addTearDown(() async {
      await closeEphemeralIsar(h.isar, h.dir);
    });

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ApplicationsController>.value(value: apps),
          ChangeNotifierProvider<AppNavigationBridge>(
            create: (_) => AppNavigationBridge(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: const HomePage(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(
      find.descendant(
        of: find.byKey(const ValueKey<String>('homeStatActive')),
        matching: find.text('4'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const ValueKey<String>('homeStatWaiting')),
        matching: find.text('2'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const ValueKey<String>('homeStatInterview')),
        matching: find.text('1'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const ValueKey<String>('homeStatArchived')),
        matching: find.text('1'),
      ),
      findsOneWidget,
    );
  });
}
