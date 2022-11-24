import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/services/route_controller.dart';
import 'package:pharmacy/ress/style/static_colors.dart';

class Buttons{
  static Widget smallButton(BuildContext context ,Constants constant, String text, Function onClick, {Color color = StaticColors.primary}) => InkWell(
                        onTap: (){
                          onClick(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            left: constant.screenWidth * 0.1, 
                            right: constant.screenWidth * 0.1,
                            top: constant.screenWidth * 0.02,
                            bottom: constant.screenWidth * 0.02,
                            ),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(constant.screenWidth * 0.02),
                          ),
                          child: Text(
                            text,
                            style: constant.textTheme.button?.copyWith(
                              color:StaticColors.text,
                            ),
                          ),
                        ),
                      );
  static Widget largeButton(BuildContext context, Constants constant, String text, Function onClick, {bool enabled=true, Color? background, Color? textColor } ) => InkWell(
                        onTap: (){
                          if(enabled)onClick(context);
                        },
                        child: Container(
                          width: constant.screenHeight * 0.4,
                          padding: EdgeInsets.only(
                            // left: constant.screenWidth * 0.1, 
                            // right: constant.screenWidth * 0.1,
                            top: constant.screenWidth * 0.02,
                            bottom: constant.screenWidth * 0.02,
                            ),
                          decoration: BoxDecoration(
                            color: enabled ? background ??StaticColors.primary : StaticColors.mutedColor,
                            borderRadius: BorderRadius.circular(constant.screenWidth * 0.05),
                          ),
                          child: Text(
                            text,
                            style: constant.textTheme.button?.copyWith(
                              color: textColor
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
  // static Widget socialButton(BuildContext context, Constants constant, String text, AssetImage image, Function onClick ) => InkWell(
  //                       onTap: (){
  //                         onClick(context);
  //                       },
  //                       child: Container(
  //                         width: constant.screenHeight * 0.4,
  //                         padding: EdgeInsets.only(
  //                           // left: constant.screenWidth * 0.1, 
  //                           // right: constant.screenWidth * 0.1,
  //                           top: constant.screenWidth * 0.02,
  //                           bottom: constant.screenWidth * 0.02,
  //                           ),
  //                         decoration: BoxDecoration(
  //                           color: StaticColors.primary,
  //                           borderRadius: BorderRadius.circular(constant.screenWidth * 0.05),
  //                         ),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Image(
  //                               image:image,
  //                               width: constant.screenWidth * 0.05,
  //                             ),
  //                             Text(
  //                               text,
  //                               style: AppTextStyle.socialButton(constant),
  //                               textAlign: TextAlign.center,
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     );
  static Widget backButton(BuildContext context, {bool visible=true}) => Visibility(
    visible: visible,
    child: IconButton(
      onPressed: (){
        AppRouteController.goBack(context);
      },
      icon: Icon(Icons.chevron_left, color: StaticColors.backgroundColor,),
    ),
  );
}
