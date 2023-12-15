import 'package:flutter/material.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class PageNavigationButton extends StatelessWidget {
  const PageNavigationButton({super.key, required this.onNextTap, required this.onPreviousTap});

  final VoidCallback onNextTap;
  final VoidCallback onPreviousTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.sp),
      height: 48.dp,
      width: 100.w,
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.circular(12.dp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () => onPreviousTap(),
            child: const Text("Previous"),
          ),
          VerticalDivider(
            indent: 10.dp,
            endIndent: 10.dp,
          ),
          TextButton(
            onPressed: () => onNextTap(),
            child: const Text("Next"),
          ),
        ],
      ),
    );
  }
}
