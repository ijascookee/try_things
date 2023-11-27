import 'package:flutter/material.dart';
import 'package:projects/rainbow_list/rainbow_list.dart';

class RainbowListHome extends StatelessWidget {
  const RainbowListHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arc Selector"),
      ),
      body: Center(
        child: RainbowList(
          height: MediaQuery.of(context).size.height / 3,
          childPadding: 1,
          items: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 2.5,
              color: Colors.red,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 2.5,
              color: Colors.green,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 2.5,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
