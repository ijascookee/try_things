import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:projects/arc_slider/arc_slider.dart';

class ArcSliderExample extends StatefulWidget {
  const ArcSliderExample({super.key});

  @override
  State<ArcSliderExample> createState() => _ArcSliderExampleState();
}

class _ArcSliderExampleState extends State<ArcSliderExample> {
  double value = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Text(
            "${value.round()}",
            style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: ArcSlider(
                  onChanged: (val) {
                    log(val.toString());
                    setState(() {
                      value = val;
                    });
                  },
                  value: value / 100,
                ),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
