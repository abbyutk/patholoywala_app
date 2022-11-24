import 'package:flutter/material.dart';
import 'package:pharmacy/ress/screen/app_widget/loading.dart';
import 'package:pharmacy/ress/screen/auth_screens/login.dart';
import 'package:pharmacy/ress/screen/auth_screens/register.dart';
import 'package:pharmacy/ress/screen/booking_details.dart';
import 'package:pharmacy/ress/screen/doctor_detail.dart';
import 'package:pharmacy/ress/screen/doctor_screen.dart';
import 'package:pharmacy/ress/screen/main_screen/main_screen.dart';
import 'package:pharmacy/ress/screen/package_detail.dart';
import 'package:pharmacy/ress/screen/package_screen.dart';
import 'package:pharmacy/ress/screen/splash.dart';
import 'package:pharmacy/ress/screen/test_screen.dart';
import './static_route_name.dart';

import '../screen/test_category_screen.dart/test_category_screen.dart';
import '../screen/test_detail_screen/test_detail_screen.dart';
import '../screen/cart_screen/cart_screen.dart';

class StaticRoute {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      StaticRouteName.testCategoryScreen: (context) =>  TestCategoryScreen(),
      StaticRouteName.testDetailScreen: (context) =>  TestDetailScreen(),
      StaticRouteName.cartScreen: (context) => CartScreen(),
    StaticRouteName.login: (context) => Login(),
      StaticRouteName.register: (context) => Register(),
      StaticRouteName.splash: (context) =>  Splash(),
      StaticRouteName.main: (context) =>  MainScreen(),
      StaticRouteName.loading: (context) =>  Loading(),
      StaticRouteName.packageDetails: (context) =>  PackageDetails(),
      StaticRouteName.doctorScreen: (context) => DoctorScreen(),
      StaticRouteName.doctorDetails: (context) => DoctorDetail(),
      StaticRouteName.testScreen: (context) => TestScreen(),
      StaticRouteName.bookingDetails: (context) => BookingDetails(),
      StaticRouteName.allPackage: (context) => PackageScreen(),
    };
  }
}
