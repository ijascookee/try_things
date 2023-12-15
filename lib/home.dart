import 'package:flutter/material.dart';
import 'package:projects/animated_gradient_text/animated_screen.dart';
import 'package:projects/arc_selector/age_range_selector.dart';
import 'package:projects/arc_selector/arc_selector_home.dart';
import 'package:projects/arc_slider/arc_slider_example.dart';
import 'package:projects/dynamic_ui/dynamic_ui_main.dart';
import 'package:projects/rainbow_list/rainbow_list_home.dart';
import 'package:projects/registration_progress/progress_registration.dart';
import 'package:projects/slider_button/slider_gradient_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Widgets"),
      ),
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: const Text("Rainbow List"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RainbowListHome()));
              },
            ),
            ListTile(
              title: const Text("Registration Process"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationProcess()));
              },
            ),
            ListTile(
              title: const Text("Arc Selector"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ArcSelectorHome()));
              },
            ),
            ListTile(
              title: const Text("Age Range Selector"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AgeRangeSelector()));
              },
            ),
            ListTile(
              title: const Text("Animated Gradient Text"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AnimatedGradientTextScreen()));
              },
            ),
            ListTile(
              title: const Text("Gradient Slider Button"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SliderGradientButton()));
              },
            ),
            ListTile(
              title: const Text("Arc Slider"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ArcSliderExample()));
              },
            ),
            ListTile(
              title: const Text("Dynamic UI"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DynamicUIMainPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
