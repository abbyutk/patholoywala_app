import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/controllers/doctor_controller.dart';
import 'package:pharmacy/controllers/test_controller.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/model/doctor.dart';
import 'package:pharmacy/ress/model/package.dart';
import 'package:pharmacy/ress/model/test.dart';
import 'package:pharmacy/ress/model/test_category_model.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/utils/static_data.dart';
import 'package:pharmacy/ress/utils/static_assets_path.dart';
import 'package:pharmacy/ress/services/route_controller.dart';

import '../../../controllers/package_controller.dart';
import '../app_widget/custom_sliver_appbar.dart';
import '../app_widget/custom_text.dart';
import '../app_widget/widget_for_expended_view.dart';
import './widget/test_list_widget.dart';
import './widget/doctor_list_widget.dart';
import './widget/test_category_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final Constants constants = Constants(context);
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
                  AppRouteController.gotoCartScreen(context);
                },
                child: SizedBox(
                  child: Icon(
                    Icons.shopping_bag,
                  ),
                ),
              ),
              appbaraction: [
                IconButton(
                  onPressed: () => AppRouteController.gotoCartScreen(context),
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: StaticColors.appBarContent,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      
                    });
                  },
                  icon: const Icon(
                    Icons.refresh,
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
                FutureBuilder(
                  future:DoctorController.getDoctors(context),
                  builder: (context, snapshot){
                    List<Doctor> doctors = [];
                    if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                      doctors = snapshot.data as List<Doctor>;
                    }
                    return snapshot.connectionState == ConnectionState.done 
                    ? DoctorListWidget(
                        titel: StaticString.topDoctorTitelText,
                        doctors:doctors,
                      )
                    : Container();
                  },
                ),
                SizedBox(
                  height: mediaQueryData.size.height * 0.02,
                ),
                FutureBuilder(
                  future:PackageController.getFeaturedPackage(context),
                  builder: (context, snapshot){
                    List<Package> packages = [];
                    if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                      packages = snapshot.data as List<Package>;
                    }
                    return snapshot.connectionState == ConnectionState.done 
                    ? SizedBox(
                      width: constants.screenWidth,
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
                                  text: 'popular Packages',
                                  textStyle: StaticStyle.textStyle(
                                    fontSide: 0.025,
                                    fontWeight: FontWeight.bold,
                                    height:constants.screenHeight,
                                  ),
                                ),
                                InkWell(
                                  onTap: ()=>AppRouteController.goTopackageScreen(context),
                                  child: CustomText(
                                    text: StaticString.testListbuttonText,
                                    textStyle: StaticStyle.textStyle(
                                      fontSide: 0.025,
                                      fontColor: StaticColors.secondary,
                                      height:constants.screenHeight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height:constants.screenHeight * 0.25,
                              width: constants.screenWidth,
                              child: ListView.separated(
                                itemCount: packages.length,
                                shrinkWrap: false,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return packages[index].render(context, constants);
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
                    )
                    : Container();
                  },
                ),
                SizedBox(
                  height: mediaQueryData.size.height * 0.02,
                ),
                FutureBuilder(
                  future:TestController.getCategories(context),
                  builder: (context, snapshot){
                    List<TestCategory> categories = [];
                    if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                      categories = snapshot.data as List<TestCategory>;
                    }
                    return snapshot.connectionState == ConnectionState.done 
                    ? TestCategoryListWidget(
                        titel: StaticString.testByCategory,
                        categories:categories,
                      )
                    : Container();
                  },
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
                FutureBuilder(
                  future:TestController.getFeaturedTests(context),
                  builder: (context, snapshot){
                    List<Test> tests = [];
                    if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                      tests = snapshot.data as List<Test>;
                    }
                    return snapshot.connectionState == ConnectionState.done 
                    ? TestListWidget(
                        titel: StaticString.topTestTitelText,
                        tests:tests,
                      )
                    : Container();
                  },
                ),
                SizedBox(
                  height: mediaQueryData.size.height * 0.02,
                ),
                // TestListWidget(
                //   titel: StaticString.recommendedTestTitelText,
                // ),
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
