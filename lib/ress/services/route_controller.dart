import 'dart:ffi';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import '../utils/static_route_name.dart';

class RouteController {
  static void gotoTestCategoryScreen(BuildContext context) {
    Navigator.of(context).pushNamed(StaticRouteName.testCategoryScreen);
  }

  static void gotoTestDetailScreen(BuildContext context) {
    Navigator.of(context).pushNamed(StaticRouteName.testDetailScreen);
  }

  static void gotoCartScreen(BuildContext context) {
    Navigator.of(context).pushNamed(StaticRouteName.cartScreen);
  }
}
