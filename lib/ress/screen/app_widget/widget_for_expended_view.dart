import 'package:flutter/material.dart';
import 'package:pharmacy/ress/style/static_style.dart';

import './circle_widget.dart';
import 'searchbar_widget.dart';

class WidgetForExpendesView extends StatelessWidget {
  final String titel;
  final Color backgroundColor;

  const WidgetForExpendesView({Key? key, required this.titel, required this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: 0,
            right: 0,
            child: Circle(),
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: kToolbarHeight,
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    left: mediaQueryData.size.width * 0.06,
                  ),
                  child: Text(
                    titel,
                    textScaleFactor: 1,
                    style: StaticStyle.textStyle(
                      fontSide: 0.03,
                      fontWeight: FontWeight.bold,
                      height: mediaQueryData.size.height,
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: mediaQueryData.size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SearchBarWidget(),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
