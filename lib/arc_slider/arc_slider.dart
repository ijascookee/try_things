import 'package:flutter/material.dart';
import 'dart:math' as math;

class ArcSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const ArcSlider({Key? key, this.value = 0.0, required this.onChanged}) : super(key: key);

  @override
  _ArcSliderState createState() => _ArcSliderState();
}

class _ArcSliderState extends State<ArcSlider> {
  double _angleToValue(double angle) {
    return (math.pi / 2 - angle) / math.pi;
  }

  double _valueToAngle(double value) {
    // This will reverse the direction of the thumb movement.
    return math.pi / 2 - (value * math.pi);
  }

  Offset _valueToPosition(double value, Size size) {
    final angle = _valueToAngle(value);
    return Offset(
      (size.width / 2) * (1 + math.cos(angle)),
      (size.height / 2) * (1 - math.sin(angle)),
    );
  }

  double _distanceBetweenPoints(Offset p1, Offset p2) {
    return math.sqrt(math.pow(p2.dx - p1.dx, 2) + math.pow(p2.dy - p1.dy, 2));
  }

  void _updateValue(Offset localPosition, Size size) {
    // Transform the local position to account for the rotation of the slider.
    // Since the slider is rotated by 90 degrees counterclockwise, we swap the x and y coordinates
    // and adjust them relative to the center of the slider.
    // `localPosition.dy - size.height / 2` calculates the y-coordinate relative to the center.
    // `localPosition.dx - size.width / 2` calculates the x-coordinate relative to the center.
    final Offset transformedPosition = Offset(localPosition.dy - size.height / 2, localPosition.dx - size.width / 2);

    // Calculate the difference in x and y from the transformed position.
    // These values are used to determine the angle and distance of the touch from the slider's center.
    final double dx = transformedPosition.dx;
    final double dy = transformedPosition.dy + 50;

    // Calculate the distance from the center of the slider to the touch point.
    // This is done using the Pythagorean theorem to find the hypotenuse of the triangle formed by dx and dy.
    final double distanceFromCenter = math.sqrt(dx * dx + dy * dy);

    // Define the radius within which the touch is considered to be on the thumb.
    // This radius should be approximately equal to the radius of the thumb for accurate touch detection.
    const double thumbRadius = 60.0;

    // Check if the touch point is within the arc's track, which is determined by the distance from the center.
    // The touch is considered valid if it is within the range of `size.width / 2 - thumbRadius` to `size.width / 2 + thumbRadius`.
    if ((size.width / 2 - thumbRadius <= distanceFromCenter) && (distanceFromCenter <= size.width / 2 + thumbRadius)) {
      // Calculate the angle of the touch relative to the slider's center.
      // `math.atan2(dy, dx)` computes the angle between the positive x-axis and the point (dx, dy).
      // `- math.pi / 2` is subtracted to adjust for the 90 degrees counterclockwise rotation of the slider.
      final angle = math.atan2(dy, dx) - math.pi / 2;

      // Normalize the angle to a value between 0 and 1 to represent the slider's value.
      // This is specific to how your slider interprets angles as values.
      final newValue = _angleToValue(angle);

      // Update the slider's value if the new value is within the valid range (0 to 1).
      // This condition ensures that the slider value doesn't go beyond its intended limits.
      if (newValue >= 0 && newValue <= 1) {
        // Convert the value to a percentage and notify the onChanged callback.
        final percentageValue = newValue * 100;
        widget.onChanged(percentageValue);
      }
    }

    // Trigger a rebuild of the widget to visually update the slider based on the new value.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -math.pi / 2,
      child: Container(
        child: GestureDetector(
          onPanUpdate: (details) {
            _updateValue(details.localPosition, context.size!);
          },
          onPanStart: (details) {
            _updateValue(details.localPosition, context.size!);
          },
          child: CustomPaint(
            painter: ArcSliderPainter(value: widget.value),
            size: Size(300, 400),
          ),
        ),
      ),
    );
  }
}

class ArcSliderPainter extends CustomPainter {
  final double value;

  ArcSliderPainter({required this.value});

  double _valueToAngle(double value) {
    // This will reverse the direction of the thumb movement.
    return math.pi / 2 - (value * math.pi);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    // Define the arc rectangle
    // Rect arcRect = Rect.fromCircle(
    //   center: Offset(0, size.height - size.height / 2),
    //   radius: size.width / 2,
    // );
    Rect arcRect = Rect.fromLTRB(0, size.height / 500, size.width / 1.5, size.height);

    // Draw the arc from -90 degrees to 90 degrees (or -pi/2 to pi/2 radians).
    canvas.drawArc(arcRect, -math.pi / 2, math.pi, false, paint);

    // Draw the thumb
    final thumbPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    final thumbPaintWhite = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final thumbPaintShadow = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    // Calculate the thumb position using the inverted angle.
    final thumbAngle = _valueToAngle(value);
    final thumbX = arcRect.center.dx + (arcRect.width / 2) * math.cos(thumbAngle);
    final thumbY = arcRect.center.dy - (arcRect.height / 2) * math.sin(thumbAngle);
    final thumbPos = Offset(thumbX, thumbY);

    canvas.drawCircle(thumbPos, 26.0, thumbPaintShadow);
    canvas.drawCircle(thumbPos, 25.0, thumbPaintWhite);
    canvas.drawCircle(thumbPos, 20.0, thumbPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
