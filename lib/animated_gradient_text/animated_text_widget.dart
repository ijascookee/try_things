import 'package:flutter/material.dart';

class AnimatedGradientTextWidget extends StatefulWidget {
  final String title;
  final Duration duration;
  final List<Color> colors;
  final List<int> stops;
  final TextStyle titleStyle;
  const AnimatedGradientTextWidget({
    super.key,
    required this.title,
    this.duration = const Duration(seconds: 8),
    required this.colors,
    required this.stops,
    this.titleStyle = const TextStyle(
      fontSize: 35.0,
      fontWeight: FontWeight.bold,
    ),
  });
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<AnimatedGradientTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String word = '';
  late int wordLength;
  late double durationPerLetter;

  @override
  void initState() {
    super.initState();
    word = widget.title;
    wordLength = word.length + 6;
    durationPerLetter = 4 / wordLength;

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 2,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    )..addListener(() {
        setState(() {});
      });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: widget.colors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: List.generate(
                widget.stops.length,
                (index) =>
                    _animation.value - (widget.stops[index] / wordLength),
              ),
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: Text(
            word,
            textAlign: TextAlign.center,
            style: widget.titleStyle,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
