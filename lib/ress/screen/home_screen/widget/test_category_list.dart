import 'package:flutter/material.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/utils/static_data.dart';
import 'package:pharmacy/ress/services/route_controller.dart';
import 'package:pharmacy/ress/model/test_category_model.dart';

import '../../app_widget/test_category_card.dart';
import '../../app_widget/custom_text.dart';

class TestCategoryListWidget extends StatelessWidget {
  final String titel;
  final List<TestCategory> categories;
  const TestCategoryListWidget({
    Key? key,
    required this.titel,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final Constants constant = Constants(context);
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
                CustomText(
                  text: titel,
                  textStyle: StaticStyle.textStyle(
                    fontSide: 0.025,
                    fontWeight: FontWeight.bold,
                    height: mediaQueryData.size.height,
                  ),
                ),
                InkWell(
                  onTap: () => AppRouteController.gotoTestCategoryScreen(context),
                  child: CustomText(
                    text: StaticString.testListbuttonText,
                    textStyle: StaticStyle.textStyle(
                      fontSide: 0.025,
                      fontColor: StaticColors.secondary,
                      height: mediaQueryData.size.height,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: mediaQueryData.size.height * 0.2,
              child: ListView.separated(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return categories[index].render(context, constant);
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
