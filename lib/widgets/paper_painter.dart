import 'dart:ui';

import 'package:flutter/widgets.dart';

class PaperPainter extends CustomPainter {
  PaperPainter(this.points, this.color);

  final List<Offset> points;
  final Color color;

  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  bool shouldRepaint(PaperPainter other) => other.points != points;
}
