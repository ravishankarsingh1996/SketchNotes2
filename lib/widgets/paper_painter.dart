import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:sketchnotes_flutter/models/PointsData.dart';

class PaperPainter extends CustomPainter {
  PaperPainter(this.points, this.color);

  final List<PointsData> points;
  final Color color;

  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = color ?? Color(0xFFFFFFFF)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null){
        paint.color = points[i].pen.color;
        canvas.drawLine(points[i].offset, points[i + 1].offset, paint);
      }
    }
  }

  bool shouldRepaint(PaperPainter other) => other.points != points;
}
