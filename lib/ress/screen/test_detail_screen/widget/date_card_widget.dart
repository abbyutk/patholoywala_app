import 'package:flutter/material.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/utils/static_data.dart';

class DateCardWidget extends StatelessWidget {
  final DateTime dateData;
  const DateCardWidget({
    Key? key,
    required this.dateData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Container(
      height: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.09,
      width: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.09,
      decoration: BoxDecoration(
        color: dateData.day == DateTime.now().day ? StaticColors.accent : Colors.grey,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: dateData.day == DateTime.now().day
          ? Center(
              child: Text(
                "Today",
                textScaleFactor: 1,
                style: StaticStyle.textStyle(
                  fontSide: 0.016,
                  fontWeight: FontWeight.bold,
                  fontColor: StaticColors.text,
                  height: mediaQueryData.size.height,
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  StaticString.weekDay[dateData.weekday - 1],
                  textScaleFactor: 1,
                  style: StaticStyle.textStyle(
                    fontSide: 0.015,
                    fontColor: StaticColors.text,
                    height: mediaQueryData.size.height,
                  ),
                ),
                Text(
                  "${dateData.day}",
                  textScaleFactor: 1,
                  style: StaticStyle.textStyle(
                    fontSide: 0.022,
                    fontWeight: FontWeight.bold,
                    fontColor: StaticColors.text,
                    height: mediaQueryData.size.height,
                  ),
                ),
              ],
            ),
    );
  }
}
