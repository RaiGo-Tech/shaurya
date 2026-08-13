import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
