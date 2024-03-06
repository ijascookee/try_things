import 'package:flutter/material.dart';
import 'dart:math' as math;

class DashedCircleBorder extends StatelessWidget {
  final double strokeWidth;
  final Gradient gradient;
  final double radius;
  final int dashCount;

  DashedCircleBorder({
    required this.strokeWidth,
    required this.radius,
    required this.gradient,
    required this.dashCount,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(2 * radius, 2 * radius),
      painter: DashedCirclePainter(
        strokeWidth: strokeWidth,
        gradient: gradient,
        dashCount: dashCount,
      ),
      child: ClipOval(
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: radius * 2,
          height: radius * 2,
        ),
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final double strokeWidth;
  final Gradient gradient;
  final int dashCount;

  DashedCirclePainter({
    required this.strokeWidth,
    required this.gradient,
    required this.dashCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final double circumference = 2 * math.pi * radius;

    paint.shader = gradient.createShader(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
    );

    if (dashCount == 1) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        0,
        math.pi * 2,
        false,
        paint,
      );
    } else {
      final double gapAngle = (2 * math.pi) / dashCount;

      for (int i = 0; i <= dashCount; i++) {
        double startAngle = i * gapAngle;
        double endAngle = (i + 0.5) * gapAngle;

        canvas.drawArc(
          Rect.fromCircle(center: Offset(radius, radius), radius: radius),
          startAngle,
          endAngle - startAngle,
          false,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
