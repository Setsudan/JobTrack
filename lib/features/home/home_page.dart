import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:job_application_tracker/core/applications/applications_controller.dart';
import 'package:job_application_tracker/core/interaction/job_track_haptics.dart';
import 'package:job_application_tracker/core/models/job_application.dart';
import 'package:job_application_tracker/features/applications/application_detail_sheet.dart';
import 'package:job_application_tracker/features/applications/widgets/job_application_status_chip.dart';
import 'package:job_application_tracker/features/home/home_application_stats.dart';
import 'package:job_application_tracker/features/home/widgets/home_stat_card.dart';
import 'package:job_application_tracker/features/shell/app_navigation_bridge.dart';
import 'package:job_application_tracker/l10n/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateFormat? _dateFormat;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String loc = Localizations.localeOf(context).toString();
    _dateFormat = DateFormat.yMMMd(loc);
  }

  String _primaryLine(JobApplication a, AppLocalizations l10n) {
    final t = a.jobTitle.trim();
    if (t.isNotEmpty) {
      return t;
    }
    final host = Uri.tryParse(a.postingUrl)?.host ?? '';
    if (host.isNotEmpty) {
      return host;
    }
    return l10n.labelJobPostingUrl;
  }

  @override
  Widget build(BuildContext context) {
    context.select<ApplicationsController, int>((ApplicationsController c) {
      return c.changeSignature;
    });
    final ApplicationsController apps = context.read<ApplicationsController>();
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final HomeApplicationStats stats = computeHomeApplicationStats(apps);
    final List<JobApplication> active = apps.activeApplications();
    final List<JobApplication> sorted = List<JobApplication>.of(active)
      ..sort((a, b) => b.submittedOn.compareTo(a.submittedOn));
    final List<JobApplication> recent = sorted.take(3).toList();
    final DateFormat df = _dateFormat ?? DateFormat.yMMMd('en');

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              const double gap = 16;
              final double tileW = (constraints.maxWidth - gap) / 2;
              Widget tile(HomeStatCard card) {
                return SizedBox(width: tileW, child: card);
              }

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  tile(
                    HomeStatCard(
                      key: const ValueKey<String>('homeStatActive'),
                      icon: Icons.work_outline,
                      title: l10n.homeStatActiveTitle,
                      value: stats.activeCount,
                      iconBackground: theme.colorScheme.primaryContainer,
                      iconColor: theme.colorScheme.onPrimaryContainer,
                      progress: stats.activeShareOfTracked,
                      onTap: () {
                        context.read<AppNavigationBridge>().goToApplications();
                      },
                    ),
                  ),
                  tile(
                    HomeStatCard(
                      key: const ValueKey<String>('homeStatWaiting'),
                      icon: Icons.hourglass_top_rounded,
                      title: l10n.homeStatWaitingTitle,
                      value: stats.waitingOnEmployerCount,
                      iconBackground: theme.colorScheme.tertiaryContainer,
                      iconColor: theme.colorScheme.onTertiaryContainer,
                      progress: stats.waitingShareOfActive,
                      onTap: () {
                        context.read<AppNavigationBridge>().goToApplications();
                      },
                    ),
                  ),
                  tile(
                    HomeStatCard(
                      key: const ValueKey<String>('homeStatInterview'),
                      icon: Icons.event_available_outlined,
                      title: l10n.homeStatInterviewTitle,
                      value: stats.interviewScheduledCount,
                      iconBackground: theme.colorScheme.secondaryContainer,
                      iconColor: theme.colorScheme.onSecondaryContainer,
                      progress: stats.interviewShareOfActive,
                      onTap: () {
                        context.read<AppNavigationBridge>().goToApplications();
                      },
                    ),
                  ),
                  tile(
                    HomeStatCard(
                      key: const ValueKey<String>('homeStatArchived'),
                      icon: Icons.inventory_2_outlined,
                      title: l10n.homeStatArchivedTitle,
                      value: stats.archivedCount,
                      iconBackground: theme.colorScheme.surfaceContainerHighest,
                      iconColor: theme.colorScheme.onSurfaceVariant,
                      progress: stats.archivedShareOfTracked,
                      onTap: () {
                        context.read<AppNavigationBridge>().goToApplications();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.homeRecentApplications,
                style: theme.textTheme.titleMedium,
              ),
              TextButton(
                onPressed: () {
                  JobTrackHaptics.button();
                  context.read<AppNavigationBridge>().goToApplications();
                },
                child: Text(l10n.homeViewAllApplications),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (recent.isEmpty)
            Text(
              l10n.applicationsEmptyActive,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            )
          else
            ...recent.map((JobApplication a) {
              final String company = a.companyName.trim();
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Material(
                  color: theme.colorScheme.surfaceContainerLow,
                  elevation: 2,
                  surfaceTintColor: Colors.transparent,
                  shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(
                      color: theme.colorScheme.outlineVariant.withValues(
                        alpha: 0.4,
                      ),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      JobTrackHaptics.button();
                      showApplicationDetailSheet(context, a.id);
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  _primaryLine(a, l10n),
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    height: 1.25,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                df.format(a.submittedOn),
                                textAlign: TextAlign.end,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              JobApplicationStatusChip(status: a.status),
                              if (company.isEmpty)
                                const Spacer()
                              else ...[
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    company,
                                    textAlign: TextAlign.end,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
