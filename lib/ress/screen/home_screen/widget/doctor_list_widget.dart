import 'package:flutter/material.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/model/doctor.dart';
import 'package:pharmacy/ress/services/route_controller.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/utils/static_data.dart';

import '../../app_widget/custom_text.dart';
import './doctor_card.dart';

class DoctorListWidget extends StatelessWidget {
  final String titel;
  final List<Doctor> doctors;
  const DoctorListWidget({
    Key? key,
    required this.titel,
    required this.doctors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Constants constant = Constants(context);
    return SizedBox(
      width: constant.screenWidth,
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
                  text: titel,
                  textStyle: StaticStyle.textStyle(
                    fontSide: 0.025,
                    fontWeight: FontWeight.bold,
                    height:constant.screenHeight,
                  ),
                ),
                InkWell(
                  onTap: ()=>AppRouteController.gotoDoctorScreen(context),
                  child: CustomText(
                    text: StaticString.testListbuttonText,
                    textStyle: StaticStyle.textStyle(
                      fontSide: 0.025,
                      fontColor: StaticColors.secondary,
                      height:constant.screenHeight,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height:constant.screenHeight * 0.25,
              width: constant.screenWidth,
              child: ListView.separated(
                itemCount: doctors.length,
                shrinkWrap: false,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return this.doctors[index].render(context, constant);
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
    );
  }
}
