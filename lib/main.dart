import 'package:flutter/material.dart';
import 'package:projects/home.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TheResponsiveBuilder(
      builder: (context, orientation, screenType) {
        return const MaterialApp(
          home: HomePage(),
        );
      },
    );
  }
}
