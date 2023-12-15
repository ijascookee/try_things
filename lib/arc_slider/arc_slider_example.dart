
import 'package:flutter/material.dart';
import 'package:projects/arc_slider/arc_slider.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class ArcSliderExample extends StatefulWidget {
  const ArcSliderExample({super.key});

  @override
  State<ArcSliderExample> createState() => _ArcSliderExampleState();
}

class _ArcSliderExampleState extends State<ArcSliderExample> {
  ValueNotifier<double> valueListener = ValueNotifier<double>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arc Slider Example"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            height: 68.dp,
            width: 68.dp,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: ValueListenableBuilder(
                  valueListenable: valueListener,
                  builder: (context, value, _) {
                    return Text(
                      value.round().toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                    );
                  }),
            ),
          ),
          const Spacer(),
          ArcSlider(
            onChange: (val) {
              valueListener.value = val;
            },
          ),
          const Spacer()
        ],
      ),
    );
  }
}
