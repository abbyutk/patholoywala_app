import 'package:flutter/material.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/model/test_category_model.dart';

import '../app_widget/custom_sliver_appbar.dart';
import '../app_widget/widget_for_expended_view.dart';
import '../app_widget/test_category_card.dart';

class TestCategoryScreen extends StatelessWidget {
  const TestCategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final List<TestCategoryModel> testCategoryList = TestCategoryModel.getCategoryList();
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: CustomSliverAppBar(
                expandedHeight: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.35,
                titel: Text(
                  "Test Category",
                  textScaleFactor: 1,
                  style: StaticStyle.textStyle(
                    fontSide: 0.03,
                    fontColor: StaticColors.appBarContent,
                    fontWeight: FontWeight.bold,
                    height: mediaQueryData.size.height,
                  ),
                ),
                backgroundColor: StaticColors.primary,
                widgetInExpendedView: [
                  const WidgetForExpendesView(
                    titel: "Test Category",
                    backgroundColor: StaticColors.primary,
                  ),
                ],
                appbarleadingWidget: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const SizedBox(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: StaticColors.appBarContent,
                    ),
                  ),
                ),
                appbaraction: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: StaticColors.appBarContent,
                    ),
                  )
                ],
              ),
              pinned: true,
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                top: 10,
                right: mediaQueryData.size.width * 0.08,
                left: mediaQueryData.size.width * 0.08,
                bottom: 10,
              ),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: mediaQueryData.size.width * 0.05,
                crossAxisSpacing: mediaQueryData.size.width * 0.05,
                children: [
                  ...testCategoryList.map(
                    (e) => TestCategoryCard(
                      testCategoryModel: e,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
