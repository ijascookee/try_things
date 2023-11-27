// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArcSelector extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final double interval;
  final bool isFractional;
  final double? initialPoint;
  final double? defaultPoint;
  final ValueChanged<double> onSnap;

  const ArcSelector({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.onSnap,
    this.interval = 5,
    this.isFractional = false,
    this.initialPoint,
    this.defaultPoint,
  });

  @override
  _ArcSelectorState createState() => _ArcSelectorState();
}

class _ArcSelectorState extends State<ArcSelector> with SingleTickerProviderStateMixin {
  double rotation = -pi / 2;
  late AnimationController _controller;
  late Animation<double> _animation;
  Offset? lastDragPosition;
  double? currentValue;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {
          rotation = _animation.value;
        });
      });

    // Set initial rotation based on initialPoint or defaultPoint
    final double step = 2 * pi / (lineCount + 5);
    if (widget.initialPoint != null) {
      if (widget.defaultPoint != null && widget.defaultPoint! >= widget.initialPoint!) {
        rotation = -pi / 2 - ((widget.defaultPoint! - widget.minValue) * step);
      } else {
        rotation = -pi / 2 - ((widget.initialPoint! - widget.minValue) * step);
      }
    }
  }

  int get lineCount {
    if (widget.isFractional) {
      return ((widget.maxValue - widget.minValue) * 10).toInt() + 1;
    } else {
      return (widget.maxValue - widget.minValue).toInt() + 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final Offset center = (context.findRenderObject() as RenderBox).size.center(Offset.zero);
    final double dx = details.localPosition.dx - center.dx;
    final double dy = details.localPosition.dy - center.dy;
    final double angle = atan2(dy, dx);

    if (lastDragPosition != null) {
      final double lastDx = lastDragPosition!.dx - center.dx;
      final double lastDy = lastDragPosition!.dy - center.dy;
      final double lastAngle = atan2(lastDy, lastDx);
      double angleDelta = angle - lastAngle;

      // Prevent rotation from going in reverse
      if (angleDelta > pi) {
        angleDelta -= 2 * pi;
      } else if (angleDelta < -pi) {
        angleDelta += 2 * pi;
      }

      // Multiply angleDelta by a factor less than 1 to reduce sensitivity
      const double sensitivityFactor = 0.3; // Adjust this value to your liking
      angleDelta *= sensitivityFactor;

      setState(() {
        rotation += angleDelta;
        final double step = 2 * pi / (lineCount + 5);
        final double calculatedMaxRotation = -pi / 2 - ((widget.maxValue - widget.minValue) * step);
        final double calculatedMinRotation = widget.initialPoint != null ? -pi / 2 - ((widget.initialPoint! - widget.minValue) * step) : -pi / 2;
        final double minRotation = min(calculatedMinRotation, calculatedMaxRotation);
        final double maxRotation = max(calculatedMinRotation, calculatedMaxRotation);
        rotation = rotation.clamp(minRotation, maxRotation);
      });
    }
    lastDragPosition = details.localPosition;
  }

  void _onPanEnd(DragEndDetails details) {
    lastDragPosition = null;
    final double step = 2 * pi / (lineCount + 5); // Adjusted for additional 5 lines
    const double offsetAngle = pi / 2;
    final double currentRotationOffset = rotation + offsetAngle;
    final double snappedRotationOffset = (currentRotationOffset / step).round() * step;
    final double snappedRotation = snappedRotationOffset - offsetAngle;

    // Constrain snapped rotation angle
    final double calculatedMaxRotation = -pi / 2 - ((widget.maxValue - widget.minValue) * step);
    final double calculatedMinRotation = widget.initialPoint != null ? -pi / 2 - ((widget.initialPoint! - widget.minValue) * step) : -pi / 2;
    final double minRotation = min(calculatedMinRotation, calculatedMaxRotation);
    final double maxRotation = max(calculatedMinRotation, calculatedMaxRotation);
    final double clampedSnappedRotation = snappedRotation.clamp(minRotation, maxRotation);

    _animation = Tween<double>(
      begin: rotation,
      end: clampedSnappedRotation,
    ).animate(_controller);

    _controller.reset();
    _controller.forward();

    int rawSnappedValue = ((lineCount) - (snappedRotationOffset / step).round()) % lineCount;

    // Adjusting the calculation for snapped value
    final double snappedValue = widget.isFractional ? widget.minValue + (rawSnappedValue / 10.0) : widget.minValue + rawSnappedValue.toDouble();
    setState(() {
      currentValue = snappedValue;
    });

    widget.onSnap(snappedValue);

    // Haptic feedback while snapping into value
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.width / 2.5,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 6,
              child: ClipPath(
                clipper: BottomClipper(),
                child: CustomPaint(
                  painter: ArcPainter(
                    minValue: widget.minValue,
                    maxValue: widget.maxValue,
                    isFractional: widget.isFractional,
                    rotation: rotation,
                    currentValue: currentValue,
                    lineCount: lineCount,
                    bigLineInterval: widget.interval,
                  ),
                  size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.width),
                ),
              ),
            ),
            Positioned(
              top: -10,
              child: SizedBox(
                height: MediaQuery.of(context).size.width / 7,
                child: const VerticalDivider(
                  color: Colors.green,
                  thickness: 2,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 30,
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 20,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 30,
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final double rotation;
  final int lineCount;
  final bool isFractional;
  final double bigLineInterval;
  final double minValue;
  final double maxValue;
  final double? currentValue;

  ArcPainter({
    this.currentValue,
    required this.isFractional,
    required this.rotation,
    required this.lineCount,
    required this.minValue,
    required this.maxValue,
    this.bigLineInterval = 5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintCircle = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final Paint paintBigLines = Paint()
      ..color = Colors.black45
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final Paint paintSmallLines = Paint()
      ..color = Colors.black45
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final Offset center = size.center(Offset.zero);
    final double radiusX = size.width / 1.8;
    final double radiusY = size.height / 1.9;
    final double radius = size.width / 2;
    final double step = 360 / (lineCount + 5);

    // Draw the circle
    canvas.drawCircle(center, radius, paintCircle);

    // Draw the indicator lines and labels
    for (int i = 0; i < lineCount; i++) {
      final double angle = (i * step * (pi / 180)) + rotation;
      final bool isBigLine = i % bigLineInterval == 0;

      final double endRadiusX = isBigLine ? radiusX - 45 : radiusX - 30;
      final double endRadiusY = isBigLine ? radiusY - 45 : radiusY - 30;
      final double startRadiusX = isBigLine ? radiusX : radiusX - 14;
      final double startRadiusY = isBigLine ? radiusY : radiusY - 14;

      final double startX = center.dx + startRadiusX * cos(angle);
      final double startY = center.dy + startRadiusY * sin(angle);
      final double endX = center.dx + endRadiusX * cos(angle);
      final double endY = center.dy + endRadiusY * sin(angle);

      // Draw the line
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), isBigLine ? paintBigLines : paintSmallLines);

      // Draw labels for big lines only
      if (isBigLine) {
        final double labelValue = isFractional ? minValue + i / 10.0 : minValue + i.toDouble();
        textPainter.text = TextSpan(
          text: labelValue.toStringAsFixed(isFractional ? 1 : 0),
          style: TextStyle(
            color: labelValue == currentValue ? Colors.green : Colors.black87,
            fontSize: 14,
          ),
        );
        textPainter.layout();
        final double textX = center.dx + (radiusX - 60) * cos(angle) - textPainter.width / 2;
        final double textY = center.dy + (radiusY - 60) * sin(angle) - textPainter.height / 2;
        textPainter.paint(canvas, Offset(textX, textY));
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, 0); // Start at the top-left corner
    path.lineTo(size.width, 0); // Line to the top-right corner
    path.lineTo(size.width, size.height / 2.5); // Line to 2/3 down the right side
    path.lineTo(0, size.height / 2.5); // Line to 2/3 down the left side
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
