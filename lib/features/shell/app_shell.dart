import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:job_application_tracker/core/interaction/job_track_haptics.dart';
import 'package:job_application_tracker/core/ui/gaussian_blur_filter.dart';
import 'package:job_application_tracker/features/applications/application_create_page.dart';
import 'package:job_application_tracker/features/applications/applications_list_page.dart';
import 'package:job_application_tracker/features/home/home_page.dart';
import 'package:job_application_tracker/features/profile/profile_page.dart';
import 'package:job_application_tracker/features/settings/settings_page.dart';
import 'package:job_application_tracker/features/shell/app_navigation_bridge.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  static const double navBarHeight = 56;
  static const double navBottomOffset = 4;
  static const double _floatingNavThumbReachClearance = 24;
  static const double _floatingEdgeInset = 20;
  static const double _topFloatingMargin = 12;
  static const double _contentGapBelowTopChrome = 8;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    return Consumer<AppNavigationBridge>(
      builder: (context, nav, _) {
        final selectedIndex = nav.tabIndex;
        final topReserve =
            padding.top +
            _topFloatingMargin +
            AppShell.navBarHeight +
            _contentGapBelowTopChrome;

        return Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(top: topReserve),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeBottom: true,
                    child: SafeArea(
                      top: false,
                      bottom: false,
                      left: true,
                      right: true,
                      child: IndexedStack(
                        index: selectedIndex,
                        sizing: StackFit.expand,
                        children: const [
                          RepaintBoundary(child: HomePage()),
                          RepaintBoundary(child: ApplicationsListPage()),
                          RepaintBoundary(child: ApplicationCreatePage()),
                          RepaintBoundary(child: ProfilePage()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                top: padding.top + _topFloatingMargin,
                end: _floatingEdgeInset,
                child: selectedIndex == 3
                    ? const _FloatingSettingsButton()
                    : _FloatingProfileButton(
                        onTap: () {
                          JobTrackHaptics.button();
                          nav.setTab(3);
                        },
                      ),
              ),
              PositionedDirectional(
                start: _floatingEdgeInset,
                bottom:
                    padding.bottom +
                    AppShell.navBottomOffset +
                    _floatingNavThumbReachClearance,
                child: _FloatingHomeListBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: nav.setTab,
                ),
              ),
              PositionedDirectional(
                end: _floatingEdgeInset,
                bottom:
                    padding.bottom +
                    AppShell.navBottomOffset +
                    _floatingNavThumbReachClearance,
                child: _FloatingCreateButton(
                  selected: selectedIndex == 2,
                  onTap: () {
                    JobTrackHaptics.button();
                    nav.setTab(2);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BlurFloatingChrome extends StatelessWidget {
  const _BlurFloatingChrome({
    required this.borderRadius,
    required this.child,
  });

  final double borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: gaussianBlurFilter(sigmaX: 16, sigmaY: 16),
        child: Material(
          color: scheme.surface.withValues(alpha: 0.55),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: scheme.outlineVariant.withValues(alpha: 0.35),
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _FloatingProfileButton extends StatelessWidget {
  const _FloatingProfileButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return _BlurFloatingChrome(
      borderRadius: AppShell.navBarHeight / 2,
      child: SizedBox(
        width: AppShell.navBarHeight,
        height: AppShell.navBarHeight,
        child: IconButton(
          key: const ValueKey<String>('shell_nav_profile'),
          onPressed: () {
            JobTrackHaptics.button();
            onTap();
          },
          tooltip: l10n.navProfile,
          style: IconButton.styleFrom(
            foregroundColor: scheme.onSurfaceVariant,
          ),
          icon: const Icon(Icons.person_outline),
        ),
      ),
    );
  }
}

class _FloatingSettingsButton extends StatelessWidget {
  const _FloatingSettingsButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return _BlurFloatingChrome(
      borderRadius: AppShell.navBarHeight / 2,
      child: SizedBox(
        width: AppShell.navBarHeight,
        height: AppShell.navBarHeight,
        child: IconButton(
          key: const ValueKey<String>('shell_nav_settings'),
          onPressed: () {
            JobTrackHaptics.button();
            Navigator.of(context).push<void>(
              MaterialPageRoute<void>(
                builder: (_) => const SettingsPage(),
              ),
            );
          },
          tooltip: l10n.settingsTitle,
          style: IconButton.styleFrom(
            foregroundColor: scheme.onSurfaceVariant,
          ),
          icon: const Icon(Icons.settings_outlined),
        ),
      ),
    );
  }
}

class _FloatingCreateButton extends StatelessWidget {
  const _FloatingCreateButton({
    required this.selected,
    required this.onTap,
  });

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return _BlurFloatingChrome(
      borderRadius: AppShell.navBarHeight / 2,
      child: SizedBox(
        width: AppShell.navBarHeight,
        height: AppShell.navBarHeight,
        child: IconButton(
          key: const ValueKey<String>('shell_nav_create'),
          onPressed: () {
            JobTrackHaptics.button();
            onTap();
          },
          tooltip: l10n.navNewApplication,
          style: IconButton.styleFrom(
            foregroundColor: selected ? scheme.primary : scheme.onSurfaceVariant,
          ),
          icon: Icon(
            selected ? Icons.add_circle : Icons.add_circle_outline,
          ),
        ),
      ),
    );
  }
}

class _FloatingHomeListBar extends StatelessWidget {
  const _FloatingHomeListBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    return _BlurFloatingChrome(
      borderRadius: 28,
      child: SizedBox(
        height: AppShell.navBarHeight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _NavEntry(
              selected: selectedIndex == 0,
              icon: Icons.home_outlined,
              selectedIcon: Icons.home,
              label: l10n.navHome,
              onTap: () {
                JobTrackHaptics.button();
                onDestinationSelected(0);
              },
              scheme: scheme,
            ),
            _NavEntry(
              selected: selectedIndex == 1,
              icon: Icons.list_alt_outlined,
              selectedIcon: Icons.list_alt,
              label: l10n.navApplications,
              onTap: () {
                JobTrackHaptics.button();
                onDestinationSelected(1);
              },
              scheme: scheme,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavEntry extends StatelessWidget {
  const _NavEntry({
    required this.selected,
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.onTap,
    required this.scheme,
  });

  final bool selected;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final VoidCallback onTap;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppShell.navBarHeight,
      height: AppShell.navBarHeight,
      child: IconButton(
        onPressed: () {
          JobTrackHaptics.button();
          onTap();
        },
        tooltip: label,
        style: IconButton.styleFrom(
          foregroundColor: selected ? scheme.primary : scheme.onSurfaceVariant,
        ),
        icon: Icon(selected ? selectedIcon : icon),
      ),
    );
  }
}
