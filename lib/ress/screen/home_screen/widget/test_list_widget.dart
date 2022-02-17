import 'package:flutter/material.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/utils/static_data.dart';

import './test_card.dart';

class TestListWidget extends StatelessWidget {
  final String titel;
  const TestListWidget({
    Key? key,
    required this.titel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return SizedBox(
      width: mediaQueryData.size.width,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  titel,
                  textScaleFactor: 1,
                  style: StaticStyle.textStyle(
                    fontSide: 0.025,
                    fontWeight: FontWeight.bold,
                    height: mediaQueryData.size.height,
                  ),
                ),
                Text(
                  StaticString.testListbuttonText,
                  textScaleFactor: 1,
                  style: StaticStyle.textStyle(
                    fontSide: 0.025,
                    fontColor: StaticColors.secondary,
                    height: mediaQueryData.size.height,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: mediaQueryData.size.height * 0.35,
              child: ListView.separated(
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const TestCard();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
