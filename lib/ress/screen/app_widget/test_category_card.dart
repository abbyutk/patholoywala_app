import 'package:flutter/material.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/model/test_category_model.dart';

class TestCategoryCard extends StatelessWidget {
  final TestCategoryModel testCategoryModel;
  const TestCategoryCard({
    Key? key,
    required this.testCategoryModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Container(
      height: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.2,
      width: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.2,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: StaticColors.testCategorybackgroundColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.6,
                width: constraints.maxWidth * 0.6,
                child: Image.asset(
                  testCategoryModel.imagePath,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                testCategoryModel.titel,
                textScaleFactor: 1,
                style: StaticStyle.textStyle(
                  fontSide: 0.02,
                  fontColor: StaticColors.primary,
                  height: mediaQueryData.size.height,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
