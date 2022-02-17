import 'package:flutter/material.dart';
import './static_route_name.dart';

import '../screen/test_category_screen.dart/test_category_screen.dart';
import '../screen/test_detail_screen/test_detail_screen.dart';
import '../screen/cart_screen/cart_screen.dart';

class StaticRoute {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      StaticRouteName.testCategoryScreen: (context) => const TestCategoryScreen(),
      StaticRouteName.testDetailScreen: (context) => const TestDetailScreen(),
      StaticRouteName.cartScreen: (context) => const CartScreen(),
    };
  }
}
