import 'package:flutter/material.dart';
import 'package:projects/arc_selector/arc_selector.dart';

class ArcSelectorHome extends StatefulWidget {
  const ArcSelectorHome({super.key});

  @override
  State<ArcSelectorHome> createState() => _ArcSelectorHomeState();
}

class _ArcSelectorHomeState extends State<ArcSelectorHome> {
  //
  double selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Arc Selector"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.width / 6,
              width: MediaQuery.of(context).size.width / 6,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  "$selectedValue",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ArcSelector(
              minValue: 4.5,
              maxValue: 8.5,
              interval: 5,
              isFractional: true,
              onSnap: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
