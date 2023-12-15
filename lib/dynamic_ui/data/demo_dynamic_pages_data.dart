import 'package:projects/dynamic_ui/models/component_model.dart';
import 'package:projects/dynamic_ui/models/dynamic_page_model.dart';

var demoDynamicPages = [
  DynamicPage(
    title: "Page1",
    components: [
      Component(name: 'v'),
      Component(name: 'i'),
      Component(name: 'o'),
      Component(name: 'b'),
    ],
  ),
  DynamicPage(
    title: "Page2",
    components: [
      Component(name: 'g'),
    ],
  ),
  DynamicPage(
    title: "Page3",
    components: [
      Component(name: 'y'),
      Component(name: 'r'),
    ],
  )
];
