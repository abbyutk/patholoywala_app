import 'package:flutter/material.dart';
import 'package:pharmacy/config/app_config.dart';

import '../../helpers/console.dart';
import '../../helpers/constants.dart';
import '../screen/app_widget/custom_text.dart';
import '../services/route_controller.dart';
import '../style/static_colors.dart';
import '../style/static_style.dart';
import '../utils/static_data.dart';

class PackageLab{
  final String name, description, image;
  final int id,price,sale;

  PackageLab({
    required this.name,
    required this.price,
    required this.sale,
    required this.description,
    required this.image,
    required this.id,
  });

  static PackageLab fromJson(json){
    Console.log(json['package_lab_id'],p: true);
    return PackageLab(
      name: json['lab_name']??'', 
      sale: int.parse(json['sale']??'0'), 
      description: json['lab_description']??'', 
      image: json['lab_image']??'', 
      price: int.parse(json['price']??'0'), 
      id: json['package_lab_id']??0
    );
  }
   Widget render(BuildContext context, Constants constant, bool activated){
    return Container(
      height:constant.screenHeight * 0.35,
      width:constant.screenHeight * 0.3,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: activated ? Colors.blue : Colors.grey[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: constant.screenHeight * 0.2,
            alignment: Alignment.center,
            child: Image.network(
              "${AppConfig.mainUrl}/$image"
            ),
          ),
          CustomText(
            text: name,
            textStyle: StaticStyle.textStyle(
              fontSide: 0.025,
              fontWeight: FontWeight.bold,
              height:constant.screenHeight,
            ),
          ),
          const Spacer(),
          CustomText(
            text: "$description",
            textStyle: StaticStyle.textStyle(
              fontSide: 0.02,
              height:constant.screenHeight,
            ),
          ),
        ],
      ),
    );
  }
}