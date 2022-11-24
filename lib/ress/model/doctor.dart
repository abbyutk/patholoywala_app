import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy/config/app_config.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/screen/app_widget/custom_text.dart';
import 'package:pharmacy/ress/services/route_controller.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';

class Doctor{

  final int id;
  final String name, specialty, description, open, close, image, price;

  Doctor({
    required this.name
  , required this.specialty
  , required this.description
  , required this.open
  , required this.close
  , required this.image
  , required this.price
  , required this.id
  });

  static Doctor fromJson(json){
    return Doctor(
      name:json["doctor_name"]??'',
      specialty:json["doctor_specialty"]??'',
      description:json["doctor_description"]??'',
      open:json["doctor_open_time"]??'',
      close:json["doctor_close_time"]??'',
      image:json["doctor_image"]??'',
      price:json["doctor_appointment_price"]??'0.00',
      id:json["doctor_id"]??0,
    );
  }

  Widget render(BuildContext context, Constants constant){
    return InkWell(
      onTap: (){
        AppRouteController.gotoDoctorDetailScreen(context, this);
      },
      child: Container(
        width: constant.screenWidth * 0.4,
        height: constant.screenWidth * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: constant.screenWidth * 0.4,
              height:constant.screenWidth * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: StaticColors.muted,
                    blurRadius: 4,
                    spreadRadius: 2,
                    offset: Offset(0,4),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage("${AppConfig.mainUrl}/${this.image}"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              this.name,
              style: StaticStyle.textStyle(fontSide: 20, height: constant.screenHeight * 0.001, fontWeight: FontWeight.bold),
            ),
            Text(
              this.specialty,
              style: StaticStyle.textStyle(fontSide: 15, height: constant.screenHeight * 0.001),
            ),
          ],
        ),
      ),
    );
  }

}