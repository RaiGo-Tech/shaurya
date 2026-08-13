import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.size = 40});
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0066FF), AppColors.primaryDark],
      ),
      borderRadius: BorderRadius.circular(size * 0.28),
      boxShadow: [
        BoxShadow(
          color: AppColors.primary.withValues(alpha: .35),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Icon(
      Icons.shield_rounded,
      color: Colors.white,
      size: size * 0.55,
    ),
  );
}

class Brand extends StatelessWidget {
  const Brand({
    super.key,
    this.compact = false,
    this.showTagline = true,
    this.onDarkBackground = false,
  });
  final bool compact;
  final bool showTagline;
  final bool onDarkBackground;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      BrandLogo(size: compact ? 34 : 40),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shaurya',
            style: TextStyle(
              color: onDarkBackground ? Colors.white : AppColors.ink,
              fontSize: compact ? 17 : 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          if (showTagline && !compact)
            Text(
              'Learn. Compete. Conquer.',
              style: TextStyle(
                color: onDarkBackground
                    ? Colors.white.withValues(alpha: .75)
                    : AppColors.muted,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    ],
  );
}
