import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'features/tests/presentation/test_attempt_page.dart';
import 'features/practice/presentation/practice_setup_page.dart';

void main() => runApp(const ShauryaApp());

class AppColors {
  static const navy = Color(0xFF082C5C);
  static const blue = Color(0xFF155EEF);
  static const sky = Color(0xFFEFF6FF);
  static const canvas = Color(0xFFF7F9FC);
  static const ink = Color(0xFF101828);
  static const muted = Color(0xFF667085);
  static const green = Color(0xFF039855);
  static const orange = Color(0xFFDC6803);
  static const border = Color(0xFFE4E7EC);
  static const lavender = Color(0xFFF5F8FF);
}

class ShauryaApp extends StatelessWidget {
  const ShauryaApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Shaurya',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.canvas,
      colorScheme: const ColorScheme.light(
        primary: AppColors.blue,
        onPrimary: Colors.white,
        secondary: AppColors.navy,
        surface: Colors.white,
        onSurface: AppColors.ink,
        error: Color(0xFFD92D20),
      ),
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 32,
          height: 1.15,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
          color: AppColors.ink,
        ),
        headlineMedium: TextStyle(
          fontSize: 26,
          height: 1.2,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.55,
          color: AppColors.ink,
        ),
        headlineSmall: TextStyle(
          fontSize: 21,
          height: 1.3,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.25,
          color: AppColors.ink,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          height: 1.35,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          height: 1.4,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
        bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: AppColors.ink),
        bodyMedium: TextStyle(
          fontSize: 14,
          height: 1.5,
          color: AppColors.muted,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          height: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.ink,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.sky,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(0, 46),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.navy,
          minimumSize: const Size(0, 44),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          side: const BorderSide(color: Color(0xFFB9C9E3)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        hintStyle: const TextStyle(color: Color(0xFF98A2B3)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.blue, width: 1.8),
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    ),
    home: const AppShell(),
  );
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool adminMode = false;
  int tab = 0;
  void navigate(int value) => setState(() => tab = value);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final desktop = width >= 900;
    final pages = adminMode
        ? [
            const AdminDashboard(),
            const AdminTable(
              title: 'Schools',
              icon: Icons.account_balance_outlined,
            ),
            const AdminTable(title: 'Students', icon: Icons.groups_outlined),
            const AdminTable(title: 'Question Bank', icon: Icons.quiz_outlined),
            const AdminTable(
              title: 'Test Calendar',
              icon: Icons.calendar_month_outlined,
            ),
          ]
        : [
            const StudentDashboard(),
            const TestsPage(),
            const PracticePage(),
            const RankingsPage(),
            const ProfilePage(),
          ];
    final labels = adminMode
        ? ['Overview', 'Schools', 'Students', 'Questions', 'Tests']
        : ['Home', 'Tests', 'Practice', 'Rankings', 'Profile'];
    final icons = adminMode
        ? [
            Icons.grid_view_rounded,
            Icons.account_balance_outlined,
            Icons.groups_outlined,
            Icons.quiz_outlined,
            Icons.calendar_month_outlined,
          ]
        : [
            Icons.home_rounded,
            Icons.assignment_outlined,
            Icons.auto_awesome_outlined,
            Icons.emoji_events_outlined,
            Icons.person_outline,
          ];

    return Scaffold(
      body: Row(
        children: [
          if (desktop)
            _SideRail(
              labels: labels,
              icons: icons,
              selected: tab,
              onSelect: navigate,
              admin: adminMode,
              onModeChanged: (v) => setState(() {
                adminMode = v;
                tab = 0;
              }),
            ),
          Expanded(
            child: Column(
              children: [
                _TopBar(
                  admin: adminMode,
                  onModeChanged: (v) => setState(() {
                    adminMode = v;
                    tab = 0;
                  }),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 360),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(.025, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    ),
                    child: KeyedSubtree(
                      key: ValueKey('$adminMode-$tab'),
                      child: pages[tab],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: desktop
          ? null
          : NavigationBar(
              selectedIndex: tab,
              onDestinationSelected: navigate,
              destinations: List.generate(
                labels.length,
                (i) => NavigationDestination(
                  icon: Icon(icons[i]),
                  label: labels[i],
                ),
              ),
            ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.admin, required this.onModeChanged});
  final bool admin;
  final ValueChanged<bool> onModeChanged;
  @override
  Widget build(BuildContext context) => Container(
    height: 78,
    padding: const EdgeInsets.symmetric(horizontal: 24),
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(bottom: BorderSide(color: AppColors.border)),
    ),
    child: Row(
      children: [
        const _Brand(compact: true),
        const Spacer(),
        if (MediaQuery.sizeOf(context).width > 600) ...[
          Text(
            admin ? 'Administration workspace' : 'Student learning space',
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(width: 16),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: false, label: Text('Student')),
              ButtonSegment(value: true, label: Text('Admin')),
            ],
            selected: {admin},
            onSelectionChanged: (s) => onModeChanged(s.first),
          ),
          const SizedBox(width: 20),
        ],
        const Badge(child: Icon(Icons.notifications_none_rounded)),
        const SizedBox(width: 16),
        const CircleAvatar(
          backgroundColor: AppColors.sky,
          child: Text(
            'A',
            style: TextStyle(
              color: AppColors.navy,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

class _SideRail extends StatelessWidget {
  const _SideRail({
    required this.labels,
    required this.icons,
    required this.selected,
    required this.onSelect,
    required this.admin,
    required this.onModeChanged,
  });
  final List<String> labels;
  final List<IconData> icons;
  final int selected;
  final ValueChanged<int> onSelect;
  final bool admin;
  final ValueChanged<bool> onModeChanged;
  @override
  Widget build(BuildContext context) => Container(
    width: 245,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.navy, Color(0xFF061E42)],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(25, 26, 20, 34),
          child: _Brand(),
        ),
        for (var i = 0; i < labels.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            child: _NavButton(
              icon: icons[i],
              label: labels[i],
              active: selected == i,
              onTap: () => onSelect(i),
            ),
          ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.tonalIcon(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF174581),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(14),
            ),
            onPressed: () => onModeChanged(!admin),
            icon: Icon(
              admin
                  ? Icons.school_outlined
                  : Icons.admin_panel_settings_outlined,
            ),
            label: Text(admin ? 'Open student app' : 'Open admin panel'),
          ),
        ),
      ],
    ),
  );
}

class _Brand extends StatelessWidget {
  const _Brand({this.compact = false});
  final bool compact;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: compact ? AppColors.blue : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.auto_stories_rounded,
          color: compact ? Colors.white : AppColors.navy,
        ),
      ),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SHAURYA',
            style: TextStyle(
              color: compact ? AppColors.navy : Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.1,
            ),
          ),
          if (!compact)
            const Text(
              'NATIONAL LEARNING',
              style: TextStyle(
                color: Color(0xFFB8D4FF),
                fontSize: 9,
                letterSpacing: .8,
              ),
            ),
        ],
      ),
    ],
  );
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: active ? const Color(0xFF1B529B) : Colors.transparent,
    borderRadius: BorderRadius.circular(10),
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: active ? Colors.white : const Color(0xFFC4D8F7),
            ),
            const SizedBox(width: 13),
            Text(
              label,
              style: TextStyle(
                color: active ? Colors.white : const Color(0xFFC4D8F7),
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});
  @override
  Widget build(BuildContext context) => _PageFrame(
    title: 'Good morning, Aarav',
    subtitle: 'Here is your learning snapshot for today.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NextTestCard(),
        const SizedBox(height: 26),
        const Text(
          'Your progress',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, c) => Wrap(
            spacing: 14,
            runSpacing: 14,
            children: const [
              _Metric(
                label: 'Latest score',
                value: '86 / 100',
                icon: Icons.workspace_premium_outlined,
                color: AppColors.blue,
              ),
              _Metric(
                label: 'All India rank',
                value: '1,248',
                icon: Icons.emoji_events_outlined,
                color: AppColors.orange,
              ),
              _Metric(
                label: 'Percentile',
                value: '96.4%',
                icon: Icons.trending_up_rounded,
                color: AppColors.green,
              ),
              _Metric(
                label: 'Tests attempted',
                value: '06 / 24',
                icon: Icons.assignment_turned_in_outlined,
                color: AppColors.navy,
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, constraints) => constraints.maxWidth > 750
              ? const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _JourneyCard()),
                    SizedBox(width: 20),
                    Expanded(child: _FocusCard()),
                  ],
                )
              : const Column(
                  children: [
                    _JourneyCard(),
                    SizedBox(height: 20),
                    _FocusCard(),
                  ],
                ),
        ),
      ],
    ),
  );
}

class _NextTestCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(26),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [AppColors.navy, Color(0xFF135BC0)],
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Wrap(
      runSpacing: 20,
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NEXT ALL INDIA TEST',
              style: TextStyle(
                color: Color(0xFFBFD9FF),
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Test #07 · Science + Mathematics',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '15 August · 10:00 AM · 60 questions · 90 mins',
              style: TextStyle(color: Color(0xFFD9E9FF)),
            ),
          ],
        ),
        FilledButton(
          onPressed: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const TestAttemptPage())),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.navy,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          child: const Text('View details'),
        ),
      ],
    ),
  );
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
  final String label, value;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    duration: const Duration(milliseconds: 520),
    curve: Curves.easeOutBack,
    tween: Tween(begin: .92, end: 1),
    builder: (context, scale, child) => Transform.scale(
      scale: scale,
      alignment: Alignment.topLeft,
      child: child,
    ),
    child: SizedBox(
      width: 185,
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha: .11),
                child: Icon(icon, color: color),
              ),
              const SizedBox(height: 17),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(color: AppColors.muted, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _JourneyCard extends StatelessWidget {
  const _JourneyCard();
  @override
  Widget build(BuildContext context) => _WhiteCard(
    title: 'My Shaurya Journey',
    child: Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Test 01  →  Test 06',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            Text(
              '+18% growth',
              style: TextStyle(
                color: AppColors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        SizedBox(
          height: 112,
          child: CustomPaint(
            painter: _LinePainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const Divider(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Accuracy', style: TextStyle(color: AppColors.muted)),
            Text('78% → 91%', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    ),
  );
}

class _FocusCard extends StatelessWidget {
  const _FocusCard();
  @override
  Widget build(BuildContext context) => _WhiteCard(
    title: 'Today’s focus',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Strengthen your weak topic',
          style: TextStyle(color: AppColors.muted),
        ),
        const SizedBox(height: 17),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.sky,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.lightbulb_outline, color: AppColors.blue),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fractions & Decimals',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '8 practice questions suggested',
                      style: TextStyle(fontSize: 12, color: AppColors.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const PracticeSetupPage()),
            ),
            child: const Text('Start practice'),
          ),
        ),
      ],
    ),
  );
}

class _WhiteCard extends StatefulWidget {
  const _WhiteCard({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  State<_WhiteCard> createState() => _WhiteCardState();
}

class _WhiteCardState extends State<_WhiteCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit: (_) => setState(() => _hovered = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
      child: Card(
        elevation: _hovered ? 5 : 0,
        shadowColor: AppColors.blue.withValues(alpha: .14),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title.isNotEmpty)
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              if (widget.title.isNotEmpty) const SizedBox(height: 19),
              widget.child,
            ],
          ),
        ),
      ),
    ),
  );
}

class _LinePainter extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final p = Paint()
      ..color = AppColors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(0, s.height * .78)
      ..cubicTo(
        s.width * .20,
        s.height * .80,
        s.width * .29,
        s.height * .44,
        s.width * .47,
        s.height * .56,
      )
      ..cubicTo(
        s.width * .65,
        s.height * .68,
        s.width * .74,
        s.height * .15,
        s.width,
        s.height * .18,
      );
    c.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TestsPage extends StatelessWidget {
  const TestsPage({super.key});
  @override
  Widget build(BuildContext context) => _PageFrame(
    title: 'National Tests',
    subtitle: 'Your official assessments for Academic Year 2026–27.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _WhiteCard(
          title: 'Upcoming',
          child: _TestTile(
            title: 'Test #07 · Science + Mathematics',
            date: '15 August 2026 · 10:00 AM',
            status: 'Start assessment',
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const TestAttemptPage())),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Previous tests',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
        ),
        const SizedBox(height: 10),
        const _WhiteCard(
          title: '',
          child: Column(
            children: [
              _TestTile(
                title: 'Test #06 · Mathematics',
                date: 'Result published · Score 86/100',
                status: 'View result',
              ),
              Divider(),
              _TestTile(
                title: 'Test #05 · Science',
                date: 'Result published · Score 78/100',
                status: 'View result',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _TestTile extends StatelessWidget {
  const _TestTile({
    required this.title,
    required this.date,
    required this.status,
    this.onPressed,
  });
  final String title, date, status;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: const CircleAvatar(
      backgroundColor: AppColors.sky,
      child: Icon(Icons.assignment_outlined, color: AppColors.blue),
    ),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
    subtitle: Text(date),
    trailing: TextButton(onPressed: onPressed, child: Text(status)),
  );
}

class PracticePage extends StatelessWidget {
  const PracticePage({super.key});
  @override
  Widget build(BuildContext context) => _PageFrame(
    title: 'Practice Zone',
    subtitle:
        'Practice builds confidence. Official rankings are never affected.',
    child: const Wrap(
      spacing: 18,
      runSpacing: 18,
      children: [
        _PracticeSubject(
          'Mathematics',
          Icons.calculate_outlined,
          '12 chapters',
        ),
        _PracticeSubject('Science', Icons.science_outlined, '10 chapters'),
        _PracticeSubject('English', Icons.menu_book_outlined, '8 chapters'),
      ],
    ),
  );
}

class _PracticeSubject extends StatelessWidget {
  const _PracticeSubject(this.name, this.icon, this.info);
  final String name, info;
  final IconData icon;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 235,
    child: Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.blue, size: 30),
            const SizedBox(height: 18),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
            ),
            Text(info, style: const TextStyle(color: AppColors.muted)),
            const SizedBox(height: 18),
            OutlinedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PracticeSetupPage(subject: name),
                ),
              ),
              child: const Text('Choose topic'),
            ),
          ],
        ),
      ),
    ),
  );
}

class RankingsPage extends StatelessWidget {
  const RankingsPage({super.key});
  @override
  Widget build(BuildContext context) => _PageFrame(
    title: 'Your Ranking',
    subtitle: 'Test #06 · National benchmark',
    child: const Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _Rank('All India Rank', '1,248', 'of 342,680 learners'),
        _Rank('State Rank', '76', 'of 24,620 learners'),
        _Rank('District Rank', '8', 'of 1,870 learners'),
        _Rank('School Rank', '2', 'of 146 learners'),
      ],
    ),
  );
}

class _Rank extends StatelessWidget {
  const _Rank(this.title, this.rank, this.caption);
  final String title, rank, caption;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 220,
    child: _WhiteCard(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rank,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              color: AppColors.navy,
            ),
          ),
          Text(
            caption,
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ],
      ),
    ),
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => _PageFrame(
    title: 'Aarav Sharma',
    subtitle: 'Class 8 · Green Valley School',
    child: const _WhiteCard(
      title: 'Account',
      child: ListTile(
        leading: CircleAvatar(radius: 24, child: Text('AS')),
        title: Text('Student ID: STU-26-HR-00001245'),
        subtitle: Text('Keep your profile and contact details up to date'),
      ),
    ),
  );
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});
  @override
  Widget build(BuildContext context) => _PageFrame(
    title: 'Administration Overview',
    subtitle: 'National platform performance · Live system view',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: const [
            _Metric(
              label: 'Total students',
              value: '248,620',
              icon: Icons.groups_outlined,
              color: AppColors.blue,
            ),
            _Metric(
              label: 'Registered schools',
              value: '1,842',
              icon: Icons.account_balance_outlined,
              color: AppColors.green,
            ),
            _Metric(
              label: 'Live tests',
              value: '02',
              icon: Icons.bolt_outlined,
              color: AppColors.orange,
            ),
            _Metric(
              label: 'Total attempts',
              value: '1.4M',
              icon: Icons.assignment_turned_in_outlined,
              color: AppColors.navy,
            ),
          ],
        ),
        const SizedBox(height: 27),
        LayoutBuilder(
          builder: (context, c) => c.maxWidth > 780
              ? const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _AdminActivity()),
                    SizedBox(width: 20),
                    Expanded(flex: 2, child: _SystemHealth()),
                  ],
                )
              : const Column(
                  children: [
                    _AdminActivity(),
                    SizedBox(height: 20),
                    _SystemHealth(),
                  ],
                ),
        ),
      ],
    ),
  );
}

class _AdminActivity extends StatelessWidget {
  const _AdminActivity();
  @override
  Widget build(BuildContext context) => _WhiteCard(
    title: 'Assessment activity',
    child: Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Test #07 participation',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '72%',
              style: TextStyle(
                color: AppColors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const LinearProgressIndicator(
          value: .72,
          minHeight: 10,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        const SizedBox(height: 25),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Submissions in last hour'),
            Text(
              '18,429',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 65,
          decoration: BoxDecoration(
            color: AppColors.sky,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Live submission activity',
            style: TextStyle(
              color: AppColors.blue,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

class _SystemHealth extends StatelessWidget {
  const _SystemHealth();
  @override
  Widget build(BuildContext context) => _WhiteCard(
    title: 'System health',
    child: const Column(
      children: [
        _Health('API availability', '99.99%', AppColors.green),
        Divider(),
        _Health('Queue processing', 'Healthy', AppColors.green),
        Divider(),
        _Health('Background jobs', '12 active', AppColors.blue),
      ],
    ),
  );
}

class _Health extends StatelessWidget {
  const _Health(this.title, this.status, this.color);
  final String title, status;
  final Color color;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title),
      Text(
        status,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

class AdminTable extends StatelessWidget {
  const AdminTable({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) => _PageFrame(
    title: title,
    subtitle: 'Manage and monitor $title across the platform.',
    child: _WhiteCard(
      title: '$title directory',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search $title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          ...List.generate(
            5,
            (i) => ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.sky,
                child: Icon(icon, color: AppColors.blue),
              ),
              title: Text('${title.substring(0, title.length - 1)} ${i + 1}'),
              subtitle: const Text('Active · Updated recently'),
              trailing: const Icon(Icons.more_horiz),
            ),
          ),
        ],
      ),
    ),
  );
}

class _PageFrame extends StatelessWidget {
  const _PageFrame({
    required this.title,
    required this.subtitle,
    required this.child,
  });
  final String title, subtitle;
  final Widget child;
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF9FBFF), AppColors.canvas],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1220),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Entrance(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              const SizedBox(height: 6),
              Text(subtitle, style: const TextStyle(color: AppColors.muted)),
              const SizedBox(height: 28),
              _Entrance(delay: 100, child: child),
            ],
          ),
        ),
      ),
    ),
  );
}

class _Entrance extends StatefulWidget {
  const _Entrance({required this.child, this.delay = 0});
  final Widget child;
  final int delay;
  @override
  State<_Entrance> createState() => _EntranceState();
}

class _EntranceState extends State<_Entrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 420 + widget.delay),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: CurvedAnimation(
      parent: _controller,
      curve: const Interval(.18, 1, curve: Curves.easeOut),
    ),
    child: SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, .045), end: Offset.zero)
          .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
          ),
      child: widget.child,
    ),
  );
}
