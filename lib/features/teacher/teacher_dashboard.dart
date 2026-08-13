import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/metric_card.dart';
import '../../core/widgets/page_frame.dart';
import '../../core/widgets/white_card.dart';
import '../auth/auth_service.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key, required this.user});
  final AppUser user;

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'Teacher Dashboard',
    subtitle: '${user.name} · ${user.school} · ${user.subtitle ?? ''}',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: .12),
                AppColors.green.withValues(alpha: .08),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary.withValues(alpha: .15)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.primaryLight,
                child: Text(
                  user.name.split(' ').map((w) => w[0]).take(2).join(),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${user.name.split(' ').first}!',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Manage your class tests, student progress, and practice assignments.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            MetricCard(
              label: 'Students in class',
              value: '146',
              icon: Icons.groups_outlined,
              color: AppColors.primary,
            ),
            MetricCard(
              label: 'Tests assigned',
              value: '24',
              icon: Icons.assignment_outlined,
              color: AppColors.green,
            ),
            MetricCard(
              label: 'Avg class score',
              value: '78.4%',
              icon: Icons.insights_outlined,
              color: AppColors.orange,
            ),
            MetricCard(
              label: 'Pending reviews',
              value: '12',
              icon: Icons.rate_review_outlined,
              color: AppColors.purple,
            ),
          ],
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, c) => c.maxWidth > 780
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: WhiteCard(
                        title: 'Class performance',
                        child: Column(
                          children: List.generate(
                            5,
                            (i) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                backgroundColor: AppColors.primaryLight,
                                child: Text('${i + 1}'),
                              ),
                              title: Text(
                                'Student ${i + 1}',
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                              subtitle: Text('Score ${82 - i * 3}/100'),
                              trailing: Text(
                                'Rank ${i + 1}',
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: WhiteCard(
                        title: 'Quick actions',
                        child: Column(
                          children: [
                            _ActionTile(Icons.quiz_outlined, 'Create practice set'),
                            const Divider(),
                            _ActionTile(Icons.assignment_outlined, 'Schedule test'),
                            const Divider(),
                            _ActionTile(Icons.analytics_outlined, 'View class report'),
                            const Divider(),
                            _ActionTile(Icons.message_outlined, 'Send announcement'),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    WhiteCard(
                      title: 'Quick actions',
                      child: Column(
                        children: [
                          _ActionTile(Icons.quiz_outlined, 'Create practice set'),
                          const Divider(),
                          _ActionTile(Icons.assignment_outlined, 'Schedule test'),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ],
    ),
  );
}

class _ActionTile extends StatelessWidget {
  const _ActionTile(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(icon, color: AppColors.primary),
    title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    trailing: const Icon(Icons.chevron_right),
    onTap: () {},
  );
}
