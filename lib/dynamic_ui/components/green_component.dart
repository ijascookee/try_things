import 'package:flutter/material.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class GreenComponent extends StatelessWidget {
  const GreenComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.dp),
      height: 96.dp,
      width: 100.w,
      color: Colors.green,
    );
  }
}
