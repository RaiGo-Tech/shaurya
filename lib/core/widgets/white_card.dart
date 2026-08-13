import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class WhiteCard extends StatefulWidget {
  const WhiteCard({super.key, required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  State<WhiteCard> createState() => _WhiteCardState();
}

class _WhiteCardState extends State<WhiteCard> {
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
