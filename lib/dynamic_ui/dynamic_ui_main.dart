import 'package:flutter/material.dart';
import 'package:projects/dynamic_ui/data/demo_dynamic_pages_data.dart';
import 'package:projects/dynamic_ui/widgets/page_content_widget.dart';
import 'package:projects/dynamic_ui/widgets/page_navigation_button.dart';
import 'package:projects/dynamic_ui/widgets/page_progress_bar.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class DynamicUIMainPage extends StatefulWidget {
  DynamicUIMainPage({super.key});

  @override
  State<DynamicUIMainPage> createState() => _DynamicUIMainPageState();
}

class _DynamicUIMainPageState extends State<DynamicUIMainPage> {
  final PageController _controller = PageController();

  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic UI Example"),
        bottom: PageProgressBar(
          height: 48.dp,
          pageTitle: demoDynamicPages[selectedPageIndex].title,
          totalPage: demoDynamicPages.length,
          currentPage: selectedPageIndex + 1,
        ),
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: demoDynamicPages.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => PageContentWidget(
                  components: demoDynamicPages[index].components,
                ),
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
            SizedBox(height: 16.dp),
            PageNavigationButton(
              onNextTap: () {
                if (selectedPageIndex < demoDynamicPages.length - 1) {
                  _controller.jumpToPage(selectedPageIndex + 1);
                  selectedPageIndex = selectedPageIndex + 1;
                  setState(() {});
                }
              },
              onPreviousTap: () {
                if (selectedPageIndex > 0) {
                  _controller.jumpToPage(selectedPageIndex - 1);
                  selectedPageIndex = selectedPageIndex - 1;
                  setState(() {});
                }
              },
            ),
            SizedBox(height: 16.dp),
          ],
        ),
      ),
    );
  }
}
