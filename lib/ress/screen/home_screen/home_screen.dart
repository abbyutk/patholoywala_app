import 'package:flutter/material.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/utils/static_data.dart';
import 'package:pharmacy/ress/utils/static_assets_path.dart';
import 'package:pharmacy/ress/services/route_controller.dart';

import '../app_widget/custom_sliver_appbar.dart';
import '../app_widget/widget_for_expended_view.dart';
import './widget/test_list_widget.dart';
import './widget/doctor_list_widget.dart';
import './widget/test_category_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: CustomSliverAppBar(
              expandedHeight: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.35,
              titel: Text(
                StaticString.appName,
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
                WidgetForExpendesView(
                  titel: StaticString.appName,
                  backgroundColor: StaticColors.primary,
                ),
              ],
              appbarleadingWidget: GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: SizedBox(
                  child: Image.asset(
                    StaticImagePath.menueIcon,
                    height: mediaQueryData.size.width * 0.5,
                    width: mediaQueryData.size.width * 0.5,
                  ),
                ),
              ),
              appbaraction: [
                IconButton(
                  onPressed: () => RouteController.gotoCartScreen(context),
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: StaticColors.appBarContent,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: StaticColors.appBarContent,
                  ),
                ),
              ],
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: mediaQueryData.size.height * 0.02,
                ),
                DoctorListWidget(
                  titel: StaticString.topDoctorTitelText,
                ),
                SizedBox(
                  height: mediaQueryData.size.height * 0.02,
                ),
                TestCategoryListWidget(
                  titel: StaticString.testByCategory,
                ),
                SizedBox(
                  height: mediaQueryData.size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                    left: 10,
                  ),
                  child: Container(
                    height: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.15,
                    width: mediaQueryData.size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: StaticColors.secondaryPrimary,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: mediaQueryData.size.width * 0.3,
                          height: double.infinity,
                          child: Image.asset(
                            StaticImagePath.rootPath + "image_covid.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                              left: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "COVID is still dangerous",
                                  textScaleFactor: 1,
                                  style: StaticStyle.textStyle(
                                    fontSide: 0.03,
                                    fontWeight: FontWeight.bold,
                                    fontColor: StaticColors.text,
                                    height: mediaQueryData.size.height,
                                  ),
                                ),
                                Text(
                                  "Always wear your mask.",
                                  textScaleFactor: 1,
                                  style: StaticStyle.textStyle(
                                    fontSide: 0.02,
                                    fontColor: StaticColors.text,
                                    height: mediaQueryData.size.height,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaQueryData.size.height * 0.02,
                ),
                TestListWidget(
                  titel: StaticString.topTestTitelText,
                ),
                SizedBox(
                  height: mediaQueryData.size.height * 0.02,
                ),
                TestListWidget(
                  titel: StaticString.recommendedTestTitelText,
                ),
                SizedBox(
                  height: mediaQueryData.size.height * 0.15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
