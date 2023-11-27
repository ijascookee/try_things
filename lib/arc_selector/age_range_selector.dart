import 'package:flutter/material.dart';
import 'package:projects/arc_selector/arc_selector.dart';

// ignore: must_be_immutable
class AgeRangeSelector extends StatelessWidget {
  //
  AgeRangeSelector({super.key});

  ValueNotifier<bool> isFromSelectedListener = ValueNotifier(true);
  //
  ValueNotifier<int> fromAgeListener = ValueNotifier(18);
  ValueNotifier<int> toAgeListener = ValueNotifier(60);

  @override
  Widget build(BuildContext context) {
    var kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Age Range Selector"),
      ),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Spacer(),
              const Text("Choose partner age"),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder(
                    valueListenable: isFromSelectedListener,
                    builder: (context, isFromSelected, _) {
                      return GestureDetector(
                        onTap: () {
                          isFromSelectedListener.value = true;
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: isFromSelected ? Colors.black87 : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ValueListenableBuilder(
                            valueListenable: fromAgeListener,
                            builder: (context, fromAge, _) {
                              return Center(
                                child: Text(
                                  "$fromAge",
                                  style: TextStyle(
                                    color: isFromSelected ? Colors.grey.shade200 : Colors.black87,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  const Text("TO"),
                  const SizedBox(width: 10),
                  ValueListenableBuilder(
                    valueListenable: isFromSelectedListener,
                    builder: (context, isFromSelected, _) {
                      return GestureDetector(
                        onTap: () {
                          isFromSelectedListener.value = false;
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: !isFromSelected ? Colors.black87 : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ValueListenableBuilder(
                            valueListenable: toAgeListener,
                            builder: (context, toAge, _) {
                              return Center(
                                child: Text(
                                  "$toAge",
                                  style: TextStyle(
                                    color: !isFromSelected ? Colors.grey.shade200 : Colors.black87,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const Spacer(),
              ValueListenableBuilder(
                valueListenable: isFromSelectedListener,
                builder: (context, isFromSelected, _) {
                  if (isFromSelected) {
                    return ArcSelector(
                      minValue: 18,
                      maxValue: 60,
                      defaultPoint: fromAgeListener.value.toDouble(),
                      onSnap: (val) {
                        if (isFromSelected) {
                          fromAgeListener.value = val.toInt();
                        }
                      },
                    );
                  } else {
                    return ValueListenableBuilder(
                      valueListenable: fromAgeListener,
                      builder: (context, fromAge, _) {
                        return ArcSelector(
                          minValue: 18,
                          maxValue: 60,
                          defaultPoint: 60,
                          initialPoint: fromAge.toDouble(),
                          onSnap: (val) {
                            if (!isFromSelected) {
                              toAgeListener.value = val.toInt();
                            }
                          },
                        );
                      },
                    );
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
