import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ArcSlider extends StatelessWidget {
  ArcSlider({
    Key? key,
    required this.onChange,
    this.initialValue = 0.0,
    this.width,
    this.minimumValue,
    this.maxiumValue,
    this.trackColor,
    this.trackThickness,
    this.trackFillColor,
    this.thumbColor,
    this.thumbBorderColor,
    this.thumbSize,
  }) : super(key: key);

  final Function(double value) onChange;
  final double initialValue;
  final double? width;
  final double? minimumValue;
  final double? maxiumValue;
  final Color? trackColor;
  final double? trackThickness;
  final Color? trackFillColor;
  final Color? thumbColor;
  final Color? thumbBorderColor;
  final double? thumbSize;

  late ValueNotifier<double> valueListener = ValueNotifier(initialValue);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      child: LayoutBuilder(builder: (context, constraints) {
        var cWidth = constraints.maxWidth;
        var cHeight = constraints.maxHeight;
        return SizedBox(
          height: cWidth / 2,
          width: cWidth,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ValueListenableBuilder(
                valueListenable: valueListener,
                builder: (context, value, _) {
                  return SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: minimumValue ?? 0,
                        maximum: maxiumValue ?? 100,
                        startAngle: 240,
                        endAngle: -60,
                        centerY: 2.3,
                        showLabels: false,
                        showTicks: false,
                        radiusFactor: 4,
                        axisLineStyle: AxisLineStyle(
                          cornerStyle: CornerStyle.bothCurve,
                          color: trackColor ?? Colors.black12,
                          thickness: trackThickness ?? 10,
                        ),
                        pointers: <GaugePointer>[
                          RangePointer(
                            value: value,
                            cornerStyle: CornerStyle.bothCurve,
                            width: trackThickness ?? 10,
                            sizeUnit: GaugeSizeUnit.logicalPixel,
                            color: trackFillColor ?? Colors.red,
                          ),
                          MarkerPointer(
                            value: value,
                            enableDragging: true,
                            onValueChanged: (val) {
                              valueListener.value = val;
                              onChange(val);
                            },
                            markerHeight: thumbSize ?? 30,
                            markerWidth: thumbSize ?? 30,
                            markerType: MarkerType.circle,
                            color: thumbColor ?? Colors.red,
                            borderWidth: 2,
                            borderColor: thumbBorderColor ?? Colors.white,
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
