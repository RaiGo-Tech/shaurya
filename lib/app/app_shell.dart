import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/widgets/brand.dart';
import '../core/widgets/performance_charts.dart';
import '../features/admin/admin_dashboard.dart';
import '../features/student/ai_tutor/ai_tutor_page.dart';
import '../features/student/dashboard/student_dashboard.dart';
import '../features/student/practice/practice_page.dart';
import '../features/student/profile/profile_page.dart';
import '../features/student/rankings/rankings_page.dart';
import '../features/student/shared/feature_page.dart';
import '../features/auth/auth_service.dart';
import '../features/auth/login_page.dart';
import '../features/student/tests/tests_page.dart';
import '../features/teacher/teacher_dashboard.dart';
import 'student_navigation.dart';

class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    required this.user,
    this.darkMode = false,
    this.onDarkModeChanged,
  });

  final AppUser user;
  final bool darkMode;
  final ValueChanged<bool>? onDarkModeChanged;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int tab = 0;
  late bool _darkMode;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool get _isTeacher => widget.user.isTeacher;

  @override
  void initState() {
    super.initState();
    _darkMode = widget.darkMode;
  }

  void navigate(int value) => setState(() => tab = value);

  void _toggleDark(bool value) {
    setState(() => _darkMode = value);
    widget.onDarkModeChanged?.call(value);
  }

  List<Widget> get _studentPages => [
    StudentDashboard(onNavigate: navigate),
    const TestsPage(),
    const PracticePage(),
    const AiTutorPage(),
    const RankingsPage(),
    const FeaturePage(
      title: 'Performance',
      subtitle: 'Deep analytics across all your tests and subjects.',
      icon: Icons.insights_outlined,
      children: [_PerformanceAnalytics()],
    ),
    const FeaturePage(
      title: 'Subjects',
      subtitle: 'Explore all subjects and chapter-wise progress.',
      icon: Icons.menu_book_outlined,
      children: [SubjectProgressList()],
    ),
    const FeaturePage(
      title: 'Weak Topics',
      subtitle: 'Focus areas identified from your test performance.',
      icon: Icons.track_changes_outlined,
      children: [_WeakTopicsList()],
    ),
    const FeaturePage(
      title: 'My Progress',
      subtitle: 'Track your growth over time.',
      icon: Icons.trending_up_rounded,
      children: [PerformanceLineChart()],
    ),
    const FeaturePage(
      title: 'Test Calendar',
      subtitle: 'All India test schedule for Academic Year 2026–27.',
      icon: Icons.calendar_month_outlined,
      children: [_TestCalendar()],
    ),
    const FeaturePage(
      title: 'Achievements',
      subtitle: 'Badges and milestones you\'ve unlocked.',
      icon: Icons.military_tech_outlined,
      children: [_AchievementsGrid()],
    ),
    ProfilePage(darkMode: _darkMode, onDarkModeChanged: _toggleDark),
  ];

  List<Widget> get _teacherPages => [
    TeacherDashboard(user: widget.user),
    const AdminTable(title: 'My Classes', icon: Icons.class_outlined),
    const AdminTable(title: 'Students', icon: Icons.groups_outlined),
    const AdminTable(title: 'Tests', icon: Icons.assignment_outlined),
    const AdminTable(title: 'Question Bank', icon: Icons.quiz_outlined),
    const AdminTable(title: 'Reports', icon: Icons.analytics_outlined),
  ];

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => LoginPage(onDarkModeChanged: widget.onDarkModeChanged),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final desktop = width >= 1024;

    final pages = _isTeacher ? _teacherPages : _studentPages;
    final maxTab = pages.length - 1;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.canvas,
      drawer: desktop
          ? null
          : Drawer(
              child: _Sidebar(
                selected: tab,
                onSelect: (i) {
                  navigate(i);
                  Navigator.pop(context);
                },
                isTeacher: _isTeacher,
                user: widget.user,
                onLogout: _logout,
              ),
            ),
      floatingActionButton: _isTeacher
          ? null
          : FloatingActionButton(
              onPressed: () => navigate(3),
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.chat_rounded),
            ),
      body: Row(
        children: [
          if (desktop)
            _Sidebar(
              selected: tab,
              onSelect: navigate,
              isTeacher: _isTeacher,
              user: widget.user,
              onLogout: _logout,
            ),
          Expanded(
            child: Column(
              children: [
                _TopBar(
                  isTeacher: _isTeacher,
                  user: widget.user,
                  onMenuTap: desktop ? null : () => _scaffoldKey.currentState?.openDrawer(),
                  onLogout: _logout,
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 280),
                    child: KeyedSubtree(
                      key: ValueKey('${_isTeacher}-$tab'),
                      child: pages[tab.clamp(0, maxTab)],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: desktop || _isTeacher
          ? null
          : NavigationBar(
              selectedIndex: mobileBottomNavMap.indexOf(tab).clamp(0, 4),
              onDestinationSelected: (i) => navigate(mobileBottomNavMap[i]),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard_rounded),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.assignment_outlined),
                  label: 'Tests',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bolt_outlined),
                  label: 'Practice',
                ),
                NavigationDestination(
                  icon: Icon(Icons.psychology_outlined),
                  label: 'AI',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
                ),
              ],
            ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.selected,
    required this.onSelect,
    required this.isTeacher,
    required this.user,
    required this.onLogout,
  });

  final int selected;
  final ValueChanged<int> onSelect;
  final bool isTeacher;
  final AppUser user;
  final VoidCallback onLogout;

  static const _teacherLabels = [
    'Dashboard',
    'My Classes',
    'Students',
    'Tests',
    'Question Bank',
    'Reports',
  ];

  static const _teacherIcons = [
    Icons.dashboard_rounded,
    Icons.class_outlined,
    Icons.groups_outlined,
    Icons.assignment_outlined,
    Icons.quiz_outlined,
    Icons.analytics_outlined,
  ];

  @override
  Widget build(BuildContext context) => Container(
    width: 260,
    decoration: BoxDecoration(
      color: Theme.of(context).cardTheme.color,
      border: Border(right: BorderSide(color: AppColors.border)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 24, 20, 20),
          child: Brand(),
        ),
        if (isTeacher)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.green.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.co_present, size: 14, color: AppColors.green),
                  SizedBox(width: 6),
                  Text(
                    'Teacher Portal',
                    style: TextStyle(
                      color: AppColors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: isTeacher
                ? List.generate(
                    _teacherLabels.length,
                    (i) => _NavItem(
                      item: StudentNavItem(
                        label: _teacherLabels[i],
                        icon: _teacherIcons[i],
                      ),
                      active: selected == i,
                      onTap: () => onSelect(i),
                    ),
                  )
                : studentNavItems
                      .map(
                        (item) => _NavItem(
                          item: item,
                          active: selected == studentNavItems.indexOf(item),
                          onTap: () => onSelect(studentNavItems.indexOf(item)),
                        ),
                      )
                      .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: isTeacher
              ? OutlinedButton.icon(
                  onPressed: onLogout,
                  icon: const Icon(Icons.logout, size: 18),
                  label: const Text('Logout'),
                )
              : _PremiumCard(onUpgrade: () {}),
        ),
        if (!isTeacher)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: OutlinedButton.icon(
              onPressed: onLogout,
              icon: const Icon(Icons.logout, size: 16),
              label: const Text('Logout', style: TextStyle(fontSize: 12)),
            ),
          ),
      ],
    ),
  );
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.active,
    required this.onTap,
  });

  final StudentNavItem item;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Material(
      color: active ? AppColors.primaryLight : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          child: Row(
            children: [
              Icon(
                item.icon,
                size: 20,
                color: active ? AppColors.primary : AppColors.muted,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 13.5,
                    color: active ? AppColors.primary : AppColors.ink,
                  ),
                ),
              ),
              if (item.aiBadge)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'AI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _PremiumCard extends StatelessWidget {
  const _PremiumCard({required this.onUpgrade});
  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF0066FF), AppColors.primaryDark],
      ),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.diamond_outlined, color: Colors.white, size: 18),
            SizedBox(width: 6),
            Text(
              'Go Premium',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Unlock All Tests, AI Explanations, Advanced Analytics & More',
          style: TextStyle(
            color: Colors.white.withValues(alpha: .85),
            fontSize: 11,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: onUpgrade,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            child: const Text('Upgrade Now', style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    ),
  );
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.isTeacher,
    required this.user,
    this.onMenuTap,
    required this.onLogout,
  });

  final bool isTeacher;
  final AppUser user;
  final VoidCallback? onMenuTap;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) => Container(
    height: 72,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(bottom: BorderSide(color: AppColors.border)),
    ),
    child: Row(
      children: [
        if (onMenuTap != null) ...[
          IconButton(icon: const Icon(Icons.menu), onPressed: onMenuTap),
          const SizedBox(width: 4),
        ],
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: TextField(
              decoration: InputDecoration(
                hintText: isTeacher
                    ? 'Search students, tests, classes...'
                    : 'Search tests, subjects, topics...',
                prefixIcon: const Icon(Icons.search, size: 20),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                filled: true,
                fillColor: AppColors.canvas,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        if (isTeacher && MediaQuery.sizeOf(context).width > 700)
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.green.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Teacher',
              style: TextStyle(
                color: AppColors.green,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        Badge(
          label: const Text('3'),
          backgroundColor: AppColors.red,
          child: IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () => _showNotifications(context),
          ),
        ),
        const SizedBox(width: 12),
        _UserChip(user: user, onLogout: onLogout),
      ],
    ),
  );

  void _showNotifications(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => const _NotificationsSheet(),
    );
  }
}

class _UserChip extends StatelessWidget {
  const _UserChip({required this.user, required this.onLogout});
  final AppUser user;
  final VoidCallback onLogout;

  String get _initials =>
      user.name.split(' ').map((w) => w[0]).take(2).join().toUpperCase();

  @override
  Widget build(BuildContext context) => PopupMenuButton<String>(
    offset: const Offset(0, 44),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    onSelected: (v) {
      if (v == 'logout') onLogout();
    },
    itemBuilder: (_) => [
      PopupMenuItem(
        enabled: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.name, style: const TextStyle(fontWeight: FontWeight.w700)),
            Text(user.id, style: const TextStyle(fontSize: 11, color: AppColors.muted)),
          ],
        ),
      ),
      const PopupMenuDivider(),
      const PopupMenuItem(
        value: 'logout',
        child: Row(
          children: [
            Icon(Icons.logout, size: 18),
            SizedBox(width: 8),
            Text('Logout'),
          ],
        ),
      ),
    ],
    child: Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.primaryLight,
          child: Text(
            _initials,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        if (MediaQuery.sizeOf(context).width > 600) ...[
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.name,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              Text(
                user.id,
                style: const TextStyle(fontSize: 10, color: AppColors.muted),
              ),
            ],
          ),
        ],
      ],
    ),
  );
}

class _NotificationsSheet extends StatelessWidget {
  const _NotificationsSheet();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Notifications', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        _NotifTile(
          icon: Icons.assignment,
          color: AppColors.primary,
          title: 'Test #07 starts in 2 days',
          subtitle: 'Science + Mathematics · 15 Aug, 10:00 AM',
        ),
        _NotifTile(
          icon: Icons.emoji_events,
          color: AppColors.orange,
          title: 'Test #06 results published',
          subtitle: 'Score 82/100 · AIR 1,248',
        ),
        _NotifTile(
          icon: Icons.auto_awesome,
          color: AppColors.purple,
          title: 'AI Tutor recommendation',
          subtitle: 'Practice Fractions & Decimals — 8 questions',
        ),
      ],
    ),
  );
}

class _NotifTile extends StatelessWidget {
  const _NotifTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: CircleAvatar(
      backgroundColor: color.withValues(alpha: .12),
      child: Icon(icon, color: color, size: 20),
    ),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
    subtitle: Text(subtitle),
  );
}

// ── Inline section widgets ──

class _PerformanceAnalytics extends StatelessWidget {
  const _PerformanceAnalytics();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const PerformanceLineChart(),
      const SizedBox(height: 20),
      const SubjectProgressList(),
    ],
  );
}

class _WeakTopicsList extends StatelessWidget {
  const _WeakTopicsList();

  @override
  Widget build(BuildContext context) {
    const topics = [
      ('Fractions & Decimals', 'Mathematics', 62),
      ('Light & Reflection', 'Science', 58),
      ('Grammar — Tenses', 'English', 65),
    ];
    return Column(
      children: topics
          .map(
            (t) => ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.orange.withValues(alpha: .12),
                child: const Icon(Icons.warning_amber_rounded, color: AppColors.orange, size: 20),
              ),
              title: Text(t.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('${t.$2} · ${t.$3}% accuracy'),
              trailing: FilledButton.tonal(
                onPressed: () {},
                child: const Text('Practice'),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _TestCalendar extends StatelessWidget {
  const _TestCalendar();

  @override
  Widget build(BuildContext context) {
    const tests = [
      ('Test #07', 'Science + Mathematics', '15 Aug 2026', true),
      ('Test #08', 'English + Social Science', '15 Sep 2026', false),
      ('Test #09', 'Mathematics + Hindi', '15 Oct 2026', false),
    ];
    return Column(
      children: tests
          .map(
            (t) => ListTile(
              leading: CircleAvatar(
                backgroundColor: t.$4
                    ? AppColors.primaryLight
                    : AppColors.border.withValues(alpha: .5),
                child: Icon(
                  Icons.calendar_today,
                  color: t.$4 ? AppColors.primary : AppColors.muted,
                  size: 18,
                ),
              ),
              title: Text(t.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('${t.$2} · ${t.$3}'),
              trailing: t.$4
                  ? const Chip(
                      label: Text('Upcoming', style: TextStyle(fontSize: 11)),
                      backgroundColor: AppColors.primaryLight,
                    )
                  : null,
            ),
          )
          .toList(),
    );
  }
}

class _AchievementsGrid extends StatelessWidget {
  const _AchievementsGrid();

  @override
  Widget build(BuildContext context) {
    const badges = [
      (Icons.emoji_events, 'Top 5%', AppColors.orange),
      (Icons.local_fire_department, '12 Day Streak', AppColors.red),
      (Icons.bolt, 'Fast Learner', AppColors.primary),
      (Icons.star, 'Perfect Score', AppColors.green),
      (Icons.psychology, 'AI Explorer', AppColors.purple),
      (Icons.military_tech, '6 Tests Done', AppColors.navy),
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: badges
          .map(
            (b) => Container(
              width: 140,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: b.$3.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: b.$3.withValues(alpha: .2)),
              ),
              child: Column(
                children: [
                  Icon(b.$1, color: b.$3, size: 28),
                  const SizedBox(height: 8),
                  Text(
                    b.$2,
                    style: TextStyle(fontWeight: FontWeight.w700, color: b.$3, fontSize: 12),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
