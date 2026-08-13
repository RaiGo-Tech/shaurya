import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/page_frame.dart';
import '../../../core/widgets/white_card.dart';

class FeaturePage extends StatelessWidget {
  const FeaturePage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.children,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) => PageFrame(
    title: title,
    subtitle: subtitle,
    child: children != null
        ? Column(children: children!)
        : _DefaultContent(title: title, icon: icon),
  );
}

class _DefaultContent extends StatelessWidget {
  const _DefaultContent({required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) => WhiteCard(
    title: title,
    child: Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: AppColors.primaryLight,
          child: Icon(icon, color: AppColors.primary, size: 32),
        ),
        const SizedBox(height: 16),
        Text(
          'Content coming soon',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'This section will be fully connected with your learning data.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    ),
  );
}
