import 'package:flutter/material.dart';

class RainbowList extends StatefulWidget {
  ///
  /// [height] is set to 1/3 of screen height.
  final double? height;

  ///
  /// [circularOffset] is set to -50
  /// This determines the horizontal offset for the card. A positive value
  /// will move the card to the right and a negative value will move it to the left.
  final double circularOffset;

  ///
  /// [verticalOffset] is set to 48
  /// This determines the vertical offset for the card. Positive values will
  /// push the card downwards and negative values will push it upwards.
  final double verticalOffset;

  ///
  /// [rotationAngle] is set to 0.3
  /// This value sets the rotation angle for the card. Positive values will rotate
  /// the card clockwise and negative values will rotate it counter-clockwise.
  final double rotationAngle;

  final double bottomPadding;

  final double childPadding;

  final List<Widget> items;

  const RainbowList({
    super.key,
    this.height,
    this.circularOffset = -50,
    this.verticalOffset = 48,
    this.rotationAngle = 0.3,
    required this.items,
    this.bottomPadding = 70,
    this.childPadding = 8,
  });

  @override
  State<RainbowList> createState() => _RainbowListState();
}

class _RainbowListState extends State<RainbowList> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.7, initialPage: widget.items.isNotEmpty ? 1 : 0)
      ..addListener(() {
        setState(() {});
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: widget.height ?? MediaQuery.of(context).size.height / 3,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: widget.bottomPadding,
              left: 0,
              right: 0,
              child: PageView.builder(
                itemCount: widget.items.length,
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                itemBuilder: (context, index) {
                  return Builder(
                    builder: (BuildContext context) {
                      if (_pageController.position.hasContentDimensions) {
                        //
                        double pageDifference = (_pageController.page ?? 0) - index;
                        double rotationAngle = -pageDifference * widget.rotationAngle;
                        double circularOffset = widget.circularOffset * pageDifference;
                        double verticalOffset = widget.verticalOffset * (pageDifference.abs());

                        return OverflowBox(
                          alignment: Alignment.center,
                          child: Transform.translate(
                            offset: Offset(circularOffset, verticalOffset),
                            child: Transform.rotate(
                              angle: rotationAngle,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: widget.childPadding),
                                child: widget.items[index],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
