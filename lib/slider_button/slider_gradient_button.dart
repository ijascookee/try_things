import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:projects/animated_gradient_text/animated_screen.dart';
import 'package:projects/slider_button/slider_widget.dart';

class SliderGradientButton extends StatefulWidget {
  const SliderGradientButton({super.key});

  @override
  State<SliderGradientButton> createState() => _SliderGradientButtonState();
}

class _SliderGradientButtonState extends State<SliderGradientButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 130),
          child: GradientSlider(
            onDragEnd: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      AnimatedGradientTextScreen(), // Replace YourNewPage with the actual page you want to navigate to
                ),
              );
            },
            text: 'Get Started',
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32), bottomLeft: Radius.circular(32)),
            textColor: Colors.black,
            // borderRadius: ,
            icon: Icon(Icons.star),
            innerGradient: LinearGradient(colors: [
              Color(0XFFFF0063),
              Color(0XFF19ACFB),
            ]),
            outerGradient: LinearGradient(colors: [Colors.white, Colors.white]),
          ),
        ),
      ),
    );
  }
}
