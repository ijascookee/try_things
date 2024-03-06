import 'package:flutter/material.dart';
import 'package:projects/dashed_circles_story/widgets/dashed_circle_widget.dart';

class DashedCircleStoryPage extends StatefulWidget {
  const DashedCircleStoryPage({super.key});

  @override
  State<DashedCircleStoryPage> createState() => _DashedCircleStoryPageState();
}

class _DashedCircleStoryPageState extends State<DashedCircleStoryPage> {
  List<int> dashCount = [3, 4, 2, 10, 12, 50, 5, 30];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            color: Colors.black,
            child: Row(
              children: List.generate(dashCount.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DashedCircleBorder(
                    dashCount: dashCount[index],
                    strokeWidth: 5,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF1FBEB0),
                        Color(0xFFFAC600),
                      ],
                    ),
                    radius: 50.0,
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
