import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy/config/app_config.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/services/route_controller.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/utils/static_assets_path.dart';

class TestCategory{
  final String name, image, description, mobileImage;
  final int id;
  TestCategory({
    required this.name,
    required this.image,
    required this.description,
    required this.mobileImage,
    required this.id,
  });

  static TestCategory fromJson(json){
    return TestCategory(
      name: json['category_name']??'',
      image: json['category_image']??'',
      description: json['category_description']??'',
      mobileImage: json['category_mobile_image']??'', 
      id: json['category_id']??0,
    );
  }

  Widget render(BuildContext context, Constants constant){
    return InkWell(
      onTap: (() => AppRouteController.gotoTestScreen(context,category: id)),
      child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: constant.screenHeight * 0.15,
                width: constant.screenWidth  * 0.4,
                child: Image.network(
                  "${AppConfig.mainUrl}/${mobileImage}",
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                name,
                textScaleFactor: 1,
                overflow: TextOverflow.ellipsis,
                style: StaticStyle.textStyle(
                  fontSide: 0.02,
                  fontColor: StaticColors.primary,
                  height: constant.screenHeight,
                ),
              ),
            ],
          ),
    );
  }

}
