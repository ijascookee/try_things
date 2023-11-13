import 'package:flutter/material.dart';
import 'package:projects/animated_gradient_text/animated_text_widget.dart';

class AnimatedGradientTextScreen extends StatefulWidget {
  const AnimatedGradientTextScreen({super.key});

  @override
  State<AnimatedGradientTextScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedGradientTextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Animated Gradient Text Screen',
        ),
      ),
      body: Center(
        child: AnimatedGradientTextWidget(
          titleStyle: TextStyle(fontSize: 120, fontWeight: FontWeight.w900),
          stops: [
            45,
            40,
            35,
            30,
            25,
            20,
            15,
            10,
            5,
            0,
          ],
          title: 'Adarsh Ijas',
          colors: [
            Color(0xFF0088C8),
            Color(0xFF00C2F3),
            Color(0xFFDEE11C),
            Color(0xFF00AF4C),
            Color(0xFFE30087),
            Color(0xFF6D2C91),
            Color(0xFFF79A1C),
            Color(0xFF0DAD49),
            Color(0xFFED1A58),
            Color(0xFF374FA2)
          ],
        ),
      ),
    );
  }
}
