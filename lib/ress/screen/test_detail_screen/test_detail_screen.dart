import 'package:flutter/material.dart';
import 'package:pharmacy/controllers/cart_controller.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/utils/static_data.dart';

import '../app_widget/custom_sliver_appbar.dart';
import './widget/date_list_widget.dart';
import './widget/time_list_widget.dart';

class TestDetailScreen extends StatelessWidget {
  const TestDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final Constants constant = Constants(context);
    Map<String,dynamic> test = constant.passedData;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: CustomSliverAppBar(
                expandedHeight: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.4,
                titel: Text(
                  test["name"]??'',
                  textScaleFactor: 1,
                  style: StaticStyle.textStyle(
                    fontSide: 0.03,
                    fontColor: StaticColors.appBarContent,
                    fontWeight: FontWeight.bold,
                    height: mediaQueryData.size.height,
                  ),
                ),
                appbarinExpendedView: false,
                backgroundColor: StaticColors.primary,
                widgetInExpendedView: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                    ),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: StaticColors.primary,
                      // child: Image.asset(
                      //   "assets/images/test.jpg",
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                    ),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.black38,
                      padding: EdgeInsets.only(
                        bottom: mediaQueryData.size.height * 0.04,
                        left: mediaQueryData.size.height * 0.04,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            test["name"],
                            textScaleFactor: 1,
                            style: StaticStyle.textStyle(
                              fontSide: 0.025,
                              fontWeight: FontWeight.bold,
                              fontColor: StaticColors.text,
                              height: mediaQueryData.size.height,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                child: Text(
                                  "Price: ",
                                  textScaleFactor: 1,
                                  style: StaticStyle.textStyle(
                                    fontSide: 0.023,
                                    fontColor: StaticColors.text,
                                    height: mediaQueryData.size.height,
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                child: Text(
                                  StaticString.rupeeSymbol + "${test['price']}/-",
                                  textScaleFactor: 1,
                                  style: StaticStyle.textStyle(
                                    fontSide: 0.023,
                                    textDecoration: TextDecoration.lineThrough,
                                    fontColor: StaticColors.text,
                                    height: mediaQueryData.size.height,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Text(
                            "Offer: " + StaticString.rupeeSymbol + "${test['price'] - (test['discount']/100 * test['price'])}/-",
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
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        height: mediaQueryData.size.height * 0.06,
                        width: mediaQueryData.size.height * 0.06,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              mediaQueryData.size.height * 0.07,
                            ),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: StaticColors.appBarContent,
                          size: StaticStyle.getAdaptiveSized(
                            mediaQueryData.size.height,
                            0.025,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                appbarleadingWidget: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: StaticColors.appBarContent,
                    size: StaticStyle.getAdaptiveSized(
                      mediaQueryData.size.height,
                      0.025,
                    ),
                  ),
                ),
                appbaraction: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: StaticColors.appBarContent,
                    ),
                  )
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
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                    ),
                    child: Text(
                      "Description",
                      textScaleFactor: 1,
                      style: StaticStyle.textStyle(
                        fontSide: 0.02,
                        fontWeight: FontWeight.bold,
                        height: mediaQueryData.size.height,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mediaQueryData.size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                    ),
                    child: Text(
                      test["description"],
                      textAlign: TextAlign.justify,
                      textScaleFactor: 1,
                      style: StaticStyle.textStyle(
                        fontSide: 0.018,
                        textOverflow: TextOverflow.clip,
                        height: mediaQueryData.size.height,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mediaQueryData.size.height,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.08,
        width: mediaQueryData.size.width * 0.9,
        child: ElevatedButton(
          onPressed: () {
            CartController.addToCart(context, test["id"].toString());
          },
          style: ElevatedButton.styleFrom(
            primary: StaticColors.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
          ),
          child: Text(
            "Add to cart",
            style: StaticStyle.textStyle(
              fontSide: 0.022,
              fontWeight: FontWeight.bold,
              fontColor: StaticColors.text,
              height: mediaQueryData.size.height,
            ),
          ),
        ),
      ),
    );
  }
}
