import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class LineChartPainter extends CustomPainter {
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
