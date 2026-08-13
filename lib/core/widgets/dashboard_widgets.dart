import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key, required this.target});
  final DateTime target;

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final diff = widget.target.difference(DateTime.now());
    setState(() => _remaining = diff.isNegative ? Duration.zero : diff);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays.toString().padLeft(2, '0');
    final hours = (_remaining.inHours % 24).toString().padLeft(2, '0');
    final mins = (_remaining.inMinutes % 60).toString().padLeft(2, '0');
    final secs = (_remaining.inSeconds % 60).toString().padLeft(2, '0');

    return Row(
      children: [
        _Unit(days, 'Days'),
        _Unit(hours, 'Hours'),
        _Unit(mins, 'Mins'),
        _Unit(secs, 'Secs'),
      ],
    );
  }
}

class _Unit extends StatelessWidget {
  const _Unit(this.value, this.label);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: AppColors.muted),
        ),
      ],
    ),
  );
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(
      color: Theme.of(context).cardTheme.color ?? Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.border.withValues(alpha: .6)),
      boxShadow: const [
        BoxShadow(
          color: AppColors.cardShadow,
          blurRadius: 16,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
}

class StatMiniCard extends StatelessWidget {
  const StatMiniCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
    this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String value;
  final String? subtitle;

  @override
  Widget build(BuildContext context) => DashboardCard(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.muted,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: const TextStyle(fontSize: 10, color: AppColors.muted),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
