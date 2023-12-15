import 'package:flutter/material.dart';
import 'package:projects/dynamic_ui/components/blue_component.dart';
import 'package:projects/dynamic_ui/components/green_component.dart';
import 'package:projects/dynamic_ui/components/indigo_component.dart';
import 'package:projects/dynamic_ui/components/orange_component.dart';
import 'package:projects/dynamic_ui/components/red_component.dart';
import 'package:projects/dynamic_ui/components/violet_component.dart';
import 'package:projects/dynamic_ui/components/yellow_component.dart';
import 'package:projects/dynamic_ui/models/component_model.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class PageContentWidget extends StatelessWidget {
  const PageContentWidget({super.key, required this.components});

  final List<Component> components;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.dp),
      child: ListView(
        shrinkWrap: true,
        children: List.generate(
          components.length,
          (index) {
            switch (components[index].name) {
              case 'v':
                return const VioletComponent();
              case 'i':
                return const IndigoComponent();

              case 'b':
                return const BlueComponent();

              case 'g':
                return const GreenComponent();

              case 'y':
                return const YellowComponent();

              case 'o':
                return const OrangeComponent();

              case 'r':
                return const RedComponent();

              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
