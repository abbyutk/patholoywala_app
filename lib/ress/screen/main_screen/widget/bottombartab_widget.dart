import 'package:flutter/material.dart';
import 'package:pharmacy/ress/style/static_style.dart';

import '../../app_widget/custom_text.dart';

class BottomBarTabWidget extends StatelessWidget {
  final IconData icon;
  final String titel;
  final Color color;
  const BottomBarTabWidget({
    Key? key,
    required this.icon,
    required this.titel,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
          ),
          CustomText(
            text: titel,
            textStyle: StaticStyle.textStyle(
              fontSide: 0.02,
              fontColor: color,
              height: mediaQueryData.size.height,
            ),
          ),
        ],
      ),
    );
  }
}
