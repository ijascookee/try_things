import 'package:flutter/material.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class IndigoComponent extends StatelessWidget {
  const IndigoComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.dp),
      height: 96.dp,
      width: 100.w,
      color: Colors.indigo,
    );
  }
}
