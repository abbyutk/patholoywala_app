import 'package:flutter/material.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/style/static_colors.dart';

class TimeCardWidget extends StatelessWidget {
  final timeData;
  final bool isCheked;
  const TimeCardWidget({
    Key? key,
    required this.isCheked,
    required this.timeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isCheked ? StaticColors.accent : null,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Text(
        timeData["text"],
        textScaleFactor: 1,
        style: StaticStyle.textStyle(
          fontSide: 0.016,
          fontColor: isCheked ? StaticColors.text : StaticColors.appBarContent,
          height: mediaQueryData.size.height,
        ),
      ),
    );
  }
}
