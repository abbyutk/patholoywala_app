import 'package:flutter/material.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/style/static_colors.dart';

import '../app_widget/custom_appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: CustomAppBar.getAppBar(
        titelText: "Cart",
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: StaticColors.appBarContent,
            size: StaticStyle.getAdaptiveSized(
              mediaQueryData.size.height,
              0.025,
            ),
          ),
        ),
        mediaQueryData: mediaQueryData,
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
