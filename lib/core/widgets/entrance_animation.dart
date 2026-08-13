import 'package:flutter/material.dart';

class EntranceAnimation extends StatefulWidget {
  const EntranceAnimation({super.key, required this.child, this.delay = 0});
  final Widget child;
  final int delay;

  @override
  State<EntranceAnimation> createState() => _EntranceAnimationState();
}

class _EntranceAnimationState extends State<EntranceAnimation>
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
