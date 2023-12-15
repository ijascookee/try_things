import 'package:flutter/material.dart';
import 'dart:math' as math;

class ArcSlider extends StatefulWidget {
  final Function(double value) onChange;
  final double initialValue;
  final double? width;
  final double? minimumValue;
  final double? maximumValue;
  final Color? trackColor;
  final double? trackThickness;
  final Color? trackFillColor;
  final Color? thumbColor;
  final Color? thumbBorderColor;
  final double? thumbSize;

  const ArcSlider({
    Key? key,
    required this.onChange,
    this.initialValue = 0.0,
    this.width,
    this.minimumValue = 0.0,
    this.maximumValue = 100.0,
    this.trackColor = Colors.black12,
    this.trackThickness = 10.0,
    this.trackFillColor = Colors.red,
    this.thumbColor = Colors.red,
    this.thumbBorderColor = Colors.white,
    this.thumbSize = 30.0,
  }) : super(key: key);

  @override
  State<ArcSlider> createState() => _ArcSliderState();
}

class _ArcSliderState extends State<ArcSlider> {
  final ValueNotifier<double> _currentValueNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _currentValueNotifier.value = widget.initialValue;
  }

  void _updateValue(Offset localPosition, Size size) {
    final double radius = size.width - (size.width / 4);
    final Offset centerPoint = Offset(size.width / 2, radius);
    final double angle = math.atan2(localPosition.dy - centerPoint.dy, localPosition.dx - centerPoint.dx);

    const double startAngle = -4.3 * math.pi / 6;
    const double sweepAngle = 2.6 * math.pi / 6;
    const double endAngle = startAngle + sweepAngle;

    if (angle >= startAngle && angle <= endAngle) {
      final double fraction = (angle - startAngle) / sweepAngle;
      final double newValue = widget.minimumValue! + fraction * (widget.maximumValue! - widget.minimumValue!);

      _currentValueNotifier.value = newValue;
      widget.onChange(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: widget.width ?? MediaQuery.of(context).size.width,
        child: LayoutBuilder(
          builder: (context, constraints) {
            var cWidth = constraints.maxWidth;
            return GestureDetector(
              onPanUpdate: (details) {
                final RenderBox box = context.findRenderObject() as RenderBox;
                final Offset localPosition = box.globalToLocal(details.globalPosition);
                _updateValue(localPosition, box.size);
              },
              child: ValueListenableBuilder(
                valueListenable: _currentValueNotifier,
                builder: (context, value, _) {
                  return CustomPaint(
                    painter: ArcSliderPainter(
                      trackColor: widget.trackColor!,
                      trackThickness: widget.trackThickness!,
                      trackFillColor: widget.trackFillColor!,
                      thumbColor: widget.thumbColor!,
                      thumbBorderColor: widget.thumbBorderColor!,
                      thumbSize: widget.thumbSize!,
                      value: value,
                      minValue: widget.minimumValue!,
                      maxValue: widget.maximumValue!,
                      radius: cWidth - (cWidth / 4),
                    ),
                    size: Size(cWidth, cWidth / 4),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _currentValueNotifier.dispose();
    super.dispose();
  }
}

class ArcSliderPainter extends CustomPainter {
  final double value;
  final double minValue;
  final double maxValue;
  final Color trackColor;
  final double trackThickness;
  final Color trackFillColor;
  final Color thumbColor;
  final Color thumbBorderColor;
  final double thumbSize;
  final double radius;

  double? _cachedThumbAngle;

  ArcSliderPainter({
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.trackColor,
    required this.trackThickness,
    required this.trackFillColor,
    required this.thumbColor,
    required this.thumbBorderColor,
    required this.thumbSize,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint trackPaint = Paint()
      ..color = trackColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackThickness;

    final Paint trackFillPaint = Paint()
      ..color = trackFillColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackThickness;

    final Paint thumbPaint = Paint()
      ..color = thumbColor
      ..style = PaintingStyle.fill;

    final Paint thumbBorderPaint = Paint()
      ..color = thumbBorderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    const double startAngle = -4.3 * math.pi / 6;
    const double sweepAngle = 2.6 * math.pi / 6;
    final double fraction = (value - minValue) / (maxValue - minValue);
    final double thumbAngle = _cachedThumbAngle ?? (startAngle + fraction * sweepAngle);

    if (_cachedThumbAngle == null || _cachedThumbAngle != thumbAngle) {
      _cachedThumbAngle = thumbAngle;
    }

    final Rect arcRect = Rect.fromCircle(center: Offset(size.width / 2, radius), radius: radius);
    canvas.drawArc(arcRect, startAngle, sweepAngle, false, trackPaint);
    canvas.drawArc(arcRect, startAngle, thumbAngle - startAngle, false, trackFillPaint);

    final Offset thumbCenter = Offset(
      size.width / 2 + math.cos(thumbAngle) * radius,
      radius + math.sin(thumbAngle) * radius,
    );
    canvas.drawCircle(thumbCenter, thumbSize / 2, thumbPaint);
    canvas.drawCircle(thumbCenter, thumbSize / 2, thumbBorderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! ArcSliderPainter || oldDelegate.value != value;
  }
}
