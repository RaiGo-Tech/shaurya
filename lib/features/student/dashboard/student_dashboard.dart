import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/dashboard_widgets.dart';
import '../../../core/widgets/performance_charts.dart';
import '../../practice/presentation/practice_setup_page.dart';
import '../../tests/presentation/test_attempt_page.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key, this.onNavigate});

  final ValueChanged<int>? onNavigate;

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _bannerPage = 0;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final wide = w >= 1100;
    final medium = w >= 768;

    return Container(
      color: AppColors.canvas,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero + Upcoming test
            if (wide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _WelcomeBanner(page: _bannerPage)),
                  const SizedBox(width: 20),
                  Expanded(flex: 2, child: _UpcomingTestCard(onNavigate: widget.onNavigate)),
                ],
              )
            else ...[
              _WelcomeBanner(page: _bannerPage),
              const SizedBox(height: 16),
              _UpcomingTestCard(onNavigate: widget.onNavigate),
            ],
            const SizedBox(height: 20),

            // Stats row
            LayoutBuilder(
              builder: (context, c) {
                final cols = c.maxWidth > 1200
                    ? 6
                    : c.maxWidth > 900
                    ? 3
                    : c.maxWidth > 600
                    ? 2
                    : 1;
                return GridView.count(
                  crossAxisCount: cols,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: cols >= 3 ? 2.8 : 2.4,
                  children: const [
                    StatMiniCard(
                      icon: Icons.emoji_events_outlined,
                      iconColor: AppColors.orange,
                      iconBg: Color(0xFFFFF6ED),
                      label: 'All India Rank',
                      value: '1,248 / 3,42,680',
                    ),
                    StatMiniCard(
                      icon: Icons.show_chart_rounded,
                      iconColor: AppColors.green,
                      iconBg: Color(0xFFECFDF3),
                      label: 'Percentile',
                      value: '96.4',
                      subtitle: 'Top 3.6% Students',
                    ),
                    StatMiniCard(
                      icon: Icons.assignment_outlined,
                      iconColor: AppColors.primary,
                      iconBg: AppColors.primaryLight,
                      label: 'Tests Completed',
                      value: '6 / 24',
                      subtitle: 'Across All Subjects',
                    ),
                    StatMiniCard(
                      icon: Icons.adjust_rounded,
                      iconColor: AppColors.purple,
                      iconBg: Color(0xFFF4F3FF),
                      label: 'Average Score',
                      value: '82.6%',
                      subtitle: 'Across All Tests',
                    ),
                    StatMiniCard(
                      icon: Icons.check_circle_outline,
                      iconColor: AppColors.green,
                      iconBg: Color(0xFFECFDF3),
                      label: 'Accuracy',
                      value: '83.67%',
                      subtitle: 'Keep it up!',
                    ),
                    StatMiniCard(
                      icon: Icons.local_fire_department_outlined,
                      iconColor: AppColors.red,
                      iconBg: Color(0xFFFEF3F2),
                      label: 'Study Streak',
                      value: '12 Days',
                      subtitle: 'Amazing!',
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),

            // Analytics row
            if (medium)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: wide ? 5 : 1,
                    child: _PerformanceCard(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: wide ? 3 : 1,
                    child: _SubjectCard(),
                  ),
                  if (wide) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 4,
                      child: _RecentResultCard(onNavigate: widget.onNavigate),
                    ),
                  ],
                ],
              )
            else ...[
              const _PerformanceCard(),
              const SizedBox(height: 16),
              const _SubjectCard(),
              const SizedBox(height: 16),
              _RecentResultCard(onNavigate: widget.onNavigate),
            ],
            if (medium && !wide) ...[
              const SizedBox(height: 16),
              _RecentResultCard(onNavigate: widget.onNavigate),
            ],
            const SizedBox(height: 20),

            // Quick actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _QuickAction(
                  icon: Icons.bolt,
                  label: 'Start Practice',
                  color: AppColors.primary,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PracticeSetupPage()),
                  ),
                ),
                _QuickAction(
                  icon: Icons.psychology_outlined,
                  label: 'AI Tutor',
                  color: AppColors.purple,
                  onTap: () => widget.onNavigate?.call(3),
                ),
                _QuickAction(
                  icon: Icons.track_changes,
                  label: 'Weak Topics',
                  color: AppColors.orange,
                  onTap: () => widget.onNavigate?.call(7),
                ),
                _QuickAction(
                  icon: Icons.calendar_month_outlined,
                  label: 'Test Calendar',
                  color: AppColors.green,
                  onTap: () => widget.onNavigate?.call(9),
                ),
                _QuickAction(
                  icon: Icons.military_tech_outlined,
                  label: 'Achievements',
                  color: AppColors.red,
                  onTap: () => widget.onNavigate?.call(10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner({required this.page});
  final int page;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFEEF4FF), Color(0xFFD6E8FF), Color(0xFFCCE0FF)],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.primary.withValues(alpha: .12)),
    ),
    child: Stack(
      children: [
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Opacity(
            opacity: .15,
            child: Icon(
              Icons.location_city_rounded,
              size: 120,
              color: AppColors.primary,
            ),
          ),
        ),
        Positioned(
          right: 24,
          top: 20,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: .2),
                  AppColors.primary.withValues(alpha: .05),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shield_rounded,
              size: 40,
              color: AppColors.primary,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back, Aarav! 👋',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Every Test. Every Step. Every Victory.',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.navy,
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 340,
              child: Text(
                'India\'s Most Advanced AI-Powered Assessment & Learning Platform.',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.muted,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_rounded, size: 18),
              label: const Text('Explore Now'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(
                3,
                (i) => Container(
                  width: i == page ? 18 : 6,
                  height: 6,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    color: i == page
                        ? AppColors.primary
                        : AppColors.primary.withValues(alpha: .25),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _UpcomingTestCard extends StatelessWidget {
  const _UpcomingTestCard({this.onNavigate});
  final ValueChanged<int>? onNavigate;

  @override
  Widget build(BuildContext context) => DashboardCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Next All India Test',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => onNavigate?.call(9),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('View Calendar →'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Test #07',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    ),
                  ),
                  const Text(
                    'Science + Mathematics',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.muted,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'August 15, 2026',
                    style: TextStyle(fontSize: 12, color: AppColors.muted),
                  ),
                ],
              ),
            ),
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.calendar_month_rounded,
                color: AppColors.primary,
                size: 28,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        CountdownTimer(
          target: DateTime(2026, 8, 15, 10),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const TestAttemptPage()),
            ),
            child: const Text('View Test Details'),
          ),
        ),
      ],
    ),
  );
}

class _PerformanceCard extends StatelessWidget {
  const _PerformanceCard();

  @override
  Widget build(BuildContext context) => DashboardCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Performance Overview',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.green.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '+18.6% improvement',
                style: TextStyle(
                  color: AppColors.green,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Your Learning Journey',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 12),
        const PerformanceLineChart(),
      ],
    ),
  );
}

class _SubjectCard extends StatelessWidget {
  const _SubjectCard();

  @override
  Widget build(BuildContext context) => DashboardCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Subject Wise Performance',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
        ),
        const SizedBox(height: 16),
        const SubjectProgressList(),
      ],
    ),
  );
}

class _RecentResultCard extends StatelessWidget {
  const _RecentResultCard({this.onNavigate});
  final ValueChanged<int>? onNavigate;

  @override
  Widget build(BuildContext context) => DashboardCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Test Result',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
        ),
        const SizedBox(height: 4),
        const Text(
          'Test #06 — Science + Mathematics',
          style: TextStyle(fontSize: 12, color: AppColors.muted),
        ),
        const Text(
          '02 Aug 2026',
          style: TextStyle(fontSize: 11, color: AppColors.muted),
        ),
        const SizedBox(height: 8),
        const ScoreDonutChart(
          score: 82,
          correct: 41,
          incorrect: 8,
          unattempted: 1,
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _LegendDot(color: AppColors.green, label: 'Correct\n41'),
            _LegendDot(color: AppColors.red, label: 'Incorrect\n8'),
            _LegendDot(color: AppColors.orange, label: 'Unattempted\n1'),
          ],
        ),
        const SizedBox(height: 8),
        const Center(
          child: Text(
            'Time taken: 42 min',
            style: TextStyle(fontSize: 12, color: AppColors.muted),
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => onNavigate?.call(5),
            child: const Text('View Detailed Analysis'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () => onNavigate?.call(3),
            icon: const Icon(Icons.auto_awesome, size: 18),
            label: const Text('Ask AI About This Test'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.purple,
            ),
          ),
        ),
      ],
    ),
  );
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(
            label.split('\n').first,
            style: const TextStyle(fontSize: 11, color: AppColors.muted),
          ),
        ],
      ),
      Text(
        label.split('\n').last,
        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
      ),
    ],
  );
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(14),
    child: Container(
      width: 130,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}
