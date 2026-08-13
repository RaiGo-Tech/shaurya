import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'entrance_animation.dart';

class PageFrame extends StatelessWidget {
  const PageFrame({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.actions,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: dark
                ? [const Color(0xFF0F1729), AppColors.darkCanvas]
                : [const Color(0xFFF9FBFF), AppColors.canvas],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1220),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EntranceAnimation(
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            subtitle,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    if (actions != null) ...actions!,
                  ],
                ),
                const SizedBox(height: 28),
                EntranceAnimation(delay: 100, child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
