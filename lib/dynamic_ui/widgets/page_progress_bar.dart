import 'package:flutter/material.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class PageProgressBar extends StatelessWidget implements PreferredSizeWidget {
  const PageProgressBar({
    super.key,
    required this.height,
    required this.totalPage,
    required this.currentPage,
    required this.pageTitle,
  });

  final double height;
  final int totalPage;
  final int currentPage;
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.dp),
            child: Text(pageTitle),
          ),
          Row(
            children: [
              SizedBox(width: 16.dp),
              Text("${((currentPage / totalPage) * 100).toInt()}%"),
              SizedBox(width: 5.dp),
              Expanded(
                child: LinearProgressIndicator(
                  value: currentPage / totalPage,
                ),
              ),
              SizedBox(width: 5.dp),
              Text("$currentPage/$totalPage"),
              SizedBox(width: 16.dp),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
