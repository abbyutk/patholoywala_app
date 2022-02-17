import 'package:flutter/material.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';

import './custom_text.dart';

class CustomAppBar {
  static PreferredSizeWidget getAppBar({
    required String titelText,
    Widget? leading,
    List<Widget> actions = const [],
    Color? backgroundColor,
    Color? iconColor,
    bool implyLeadingAction = false,
    TextStyle? titelStyle,
    double elevation = 0,
    required MediaQueryData mediaQueryData,
  }) {
    return AppBar(
      leading: leading,
      title: CustomText(
        text: titelText,
        textStyle: titelStyle ??
            StaticStyle.textStyle(
              fontSide: 0.03,
              fontColor: StaticColors.appBarContent,
              fontWeight: FontWeight.bold,
              height: mediaQueryData.size.height,
            ),
      ),
      automaticallyImplyLeading: implyLeadingAction,
      elevation: elevation,
      actions: actions,
      backgroundColor: backgroundColor ?? StaticColors.primary,
      iconTheme: IconThemeData(
        color: iconColor ?? StaticColors.appBarContent,
      ),
    );
  }
}
