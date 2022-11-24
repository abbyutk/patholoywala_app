import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/screen/app_widget/custom_text.dart';
import 'package:pharmacy/ress/services/route_controller.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';
// import 'package:html/parser.dart' show parse;
import 'package:pharmacy/ress/utils/static_data.dart';

class Test{

  final int id, discount, price;
  final String name, description, collection;

  Test({
    required this.name, 
    required this.description, 
    required this.price, 
    required this.discount, 
    required this.collection, 
    required this.id
  });

  static Test fromJson(json){
    return Test(
      name:json["test_name"]??"", 
      description:json["test_description"]??"", 
      price:json["test_price"]??0, 
      discount:int.parse(json["test_discount"]??"0"), 
      collection:json["test_collection"]??"", 
      id:json["test_id"]??0, 
    );
  }

  Widget render(BuildContext context, Constants constant){
    return Container(
      height:constant.screenHeight * 0.35,
      width:constant.screenHeight * 0.3,
      padding: const EdgeInsets.all(10),
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: name,
            textStyle: StaticStyle.textStyle(
              fontSide: 0.025,
              fontWeight: FontWeight.bold,
              height:constant.screenHeight,
            ),
          ),
          // const Spacer(),
          // CustomText(
          //   text: "Includes :  77 Parameters",
          //   textStyle: StaticStyle.textStyle(
          //     fontSide: 0.02,
          //     height:constant.screenHeight,
          //   ),
          // ),
          const Spacer(),
          SizedBox(
            width: constant.screenWidth,
            // child: parse(),
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: () => AppRouteController.gotoTestDetailScreen(context, name, description, price, discount, id),
            child: CustomText(
              text: "+ Know More",
              textStyle: StaticStyle.textStyle(
                fontSide: 0.02,
                fontColor: StaticColors.primary,
                height:constant.screenHeight,
              ),
            ),
            style: OutlinedButton.styleFrom(
              primary: StaticColors.primary,
              side: const BorderSide(
                color: StaticColors.primary,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: CustomText(
                    text: "${StaticString.rupeeSymbol}$price",
                    textStyle: StaticStyle.textStyle(
                      fontSide: 0.025,
                      fontWeight: FontWeight.bold,
                      fontColor: StaticColors.muted,
                      textDecoration: TextDecoration.lineThrough,
                      height:constant.screenHeight,
                    ),
                  ),
                ),
                WidgetSpan(
                  child: CustomText(
                    text: "  ${StaticString.rupeeSymbol}${price - ((discount/100) * price)}",
                    textStyle: StaticStyle.textStyle(
                      fontSide: 0.03,
                      fontWeight: FontWeight.bold,
                      fontColor: StaticColors.primary,
                      height:constant.screenHeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}