import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/brand.dart';
import '../../app/app_shell.dart';
import 'auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.onDarkModeChanged});
  final ValueChanged<bool>? onDarkModeChanged;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _userId = TextEditingController();
  final _password = TextEditingController();
  UserRole _role = UserRole.student;
  bool _loading = false;
  bool _obscure = true;
  String? _error;
  late final AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _fillDemoCredentials();
  }

  void _fillDemoCredentials() {
    if (_role == UserRole.student) {
      _userId.text = DemoCredentials.studentId;
      _password.text = DemoCredentials.studentPassword;
    } else {
      _userId.text = DemoCredentials.teacherId;
      _password.text = DemoCredentials.teacherPassword;
    }
  }

  @override
  void dispose() {
    _anim.dispose();
    _userId.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_loading) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    await Future<void>.delayed(const Duration(milliseconds: 600));

    final result = DemoCredentials.signIn(
      userId: _userId.text,
      password: _password.text,
      role: _role,
    );

    if (!mounted) return;

    if (!result.ok) {
      setState(() {
        _loading = false;
        _error = result.error;
      });
      return;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => AppShell(
          user: result.user!,
          onDarkModeChanged: widget.onDarkModeChanged,
        ),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 450),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    return Scaffold(
      body: Row(
        children: [
          if (wide) Expanded(child: _HeroPanel(animation: _anim)),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _anim,
                    curve: const Interval(.2, 1, curve: Curves.easeOut),
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!wide) const Center(child: Brand(showTagline: true)),
                        if (!wide) const SizedBox(height: 36),
                        Text(
                          'Welcome back',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in as student or teacher to continue.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),
                        SegmentedButton<UserRole>(
                          segments: const [
                            ButtonSegment(
                              value: UserRole.student,
                              label: Text('Student'),
                              icon: Icon(Icons.school_outlined, size: 18),
                            ),
                            ButtonSegment(
                              value: UserRole.teacher,
                              label: Text('Teacher'),
                              icon: Icon(Icons.co_present_outlined, size: 18),
                            ),
                          ],
                          selected: {_role},
                          onSelectionChanged: (s) {
                            setState(() {
                              _role = s.first;
                              _error = null;
                              _fillDemoCredentials();
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _userId,
                          decoration: InputDecoration(
                            labelText: _role == UserRole.student
                                ? 'Student ID'
                                : 'Teacher ID',
                            prefixIcon: const Icon(Icons.badge_outlined),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _password,
                          obscureText: _obscure,
                          onSubmitted: (_) => _signIn(),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                            ),
                          ),
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            _error!,
                            style: const TextStyle(
                              color: AppColors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('Forgot password?'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _loading ? null : _signIn,
                            child: _loading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    _role == UserRole.student
                                        ? 'Sign in as Student'
                                        : 'Sign in as Teacher',
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _DemoCredentialsCard(role: _role),
                        const SizedBox(height: 16),
                        const _TrustBadges(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoCredentialsCard extends StatelessWidget {
  const _DemoCredentialsCard({required this.role});
  final UserRole role;

  @override
  Widget build(BuildContext context) {
    final isStudent = role == UserRole.student;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: .45),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: .15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isStudent ? Icons.school : Icons.co_present,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
              Text(
                'Demo ${isStudent ? 'Student' : 'Teacher'} Login',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _CredRow(
            'ID',
            isStudent ? DemoCredentials.studentId : DemoCredentials.teacherId,
          ),
          _CredRow(
            'Password',
            isStudent
                ? DemoCredentials.studentPassword
                : DemoCredentials.teacherPassword,
          ),
        ],
      ),
    );
  }
}

class _CredRow extends StatelessWidget {
  const _CredRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 4),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 12, color: AppColors.ink, height: 1.5),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          TextSpan(text: value),
        ],
      ),
    ),
  );
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({required this.animation});
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.primary, Color(0xFF0041A8), Color(0xFF003080)],
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          top: -80,
          right: -60,
          child: FadeTransition(
            opacity: animation,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: .06),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Brand(showTagline: true, onDarkBackground: true),
              const Spacer(),
              FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: const Interval(.15, 1, curve: Curves.easeOut),
                ),
                child: const Text(
                  'India\'s Most Advanced\nAI-Powered Learning Platform',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    height: 1.2,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Learn. Compete. Conquer.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .8),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    ),
  );
}

class _TrustBadges extends StatelessWidget {
  const _TrustBadges();

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.verified_user_outlined,
        size: 16,
        color: Theme.of(context).colorScheme.primary,
      ),
      const SizedBox(width: 6),
      Text(
        'Secure · Encrypted · Ministry aligned',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
      ),
    ],
  );
}
