import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/model/package_lab.dart';
import 'package:pharmacy/ress/model/test_category_model.dart';
import 'package:pharmacy/ress/model/test_lab.dart';
import 'package:pharmacy/ress/screen/app_widget/custom_text.dart';
import 'package:pharmacy/ress/services/route_controller.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';
// import 'package:html/parser.dart' show parse;
import 'package:pharmacy/ress/utils/static_data.dart';

class Package{

  final int id, tests;
  final String title, description;
  final String category;
  final List<PackageLab> labs;

  Package({
    required this.title, 
    required this.description,
    required this.category, 
    required this.labs, 
    required this.id,
    required this.tests,
  });

  static Package fromJson(json){
    List<PackageLab> labList = [];
    labList = (json["lab_details"] as List).map<PackageLab>((e) => PackageLab.fromJson(e)).toList();
    return Package(
      title:json["package_title"]??"", 
      description:json["package_description"]??"",
      tests:int.parse(json['package_total_test']??'0'),
      id:json["package_id"]??0, 
      category: json['category_name']??'', 
      labs: labList 
    );
  }

  Widget render(BuildContext context, Constants constant){
    return InkWell(
      onTap: (){
        AppRouteController.gotoPackageDetailScreen(context, this);
      },
      child: Container(
        height:constant.screenHeight * 0.2,
        width:constant.screenHeight * 0.3,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xffeeb9b9).withOpacity(0.8),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: title,
              textStyle: StaticStyle.textStyle(
                fontSide: 0.025,
                fontWeight: FontWeight.bold,
                height:constant.screenHeight,
              ),
            ),
            // const Spacer(),
            CustomText(
              text: "${tests}+ tests includes",
              textStyle: StaticStyle.textStyle(
                fontSide: 0.025,
                fontColor: Color(0xffc85353),
                fontWeight: FontWeight.bold,
                height:constant.screenHeight,
              ),
            ),
            // const Spacer(),
            // OutlinedButton(
            //   onPressed: (){
            //     AppRouteController.gotoPackageDetailScreen(context, this);
            //   },
            //   child: CustomText(
            //     text: "+ Know More",
            //     textStyle: StaticStyle.textStyle(
            //       fontSide: 0.02,
            //       fontColor: StaticColors.primary,
            //       height:constant.screenHeight,
            //     ),
            //   ),
            //   style: OutlinedButton.styleFrom(
            //     primary: StaticColors.primary,
            //     side: const BorderSide(
            //       color: StaticColors.primary,
            //     ),
            //     shape: const RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(
            //           20,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // const Spacer(),
            // RichText(
            //   text: TextSpan(
            //     children: [
            //       WidgetSpan(
            //         child: CustomText(
            //           text: "",
            //           textStyle: StaticStyle.textStyle(
            //             fontSide: 0.025,
            //             fontWeight: FontWeight.bold,
            //             fontColor: StaticColors.muted,
            //             textDecoration: TextDecoration.lineThrough,
            //             height:constant.screenHeight,
            //           ),
            //         ),
            //       ),
            //       WidgetSpan(
            //         child: CustomText(
            //           text: "",
            //           textStyle: StaticStyle.textStyle(
            //             fontSide: 0.03,
            //             fontWeight: FontWeight.bold,
            //             fontColor: StaticColors.primary,
            //             height:constant.screenHeight,
            //           ),
            //         ),
            //       ),
                // ],
              // ),
            // ),
          ],
        ),
      ),
    );
  }

}