import 'dart:ffi';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:pharmacy/ress/model/booking.dart';
import 'package:pharmacy/ress/model/doctor.dart';
import 'package:pharmacy/ress/model/package.dart';
import 'package:pharmacy/ress/model/test.dart';
import '../utils/static_route_name.dart';

class AppRouteController {
  static void gotoTestCategoryScreen(BuildContext context) {
    Navigator.of(context).pushNamed(StaticRouteName.testCategoryScreen);
  }

  static goBack(context){
    Navigator.pop(context);
  }

  static void gotoTestDetailScreen(BuildContext context, String name, String description, int price, int discount, int id) {
    Navigator.of(context).pushNamed(StaticRouteName.testDetailScreen,arguments: {"id":id,"name":name,"price":price,"discount":discount,"description":description});
  }

  static void gotoCartScreen(BuildContext context) {
    Navigator.of(context).pushNamed(StaticRouteName.cartScreen);
  }
  static void gotoSplashScreen(BuildContext context) {
    Navigator.of(context).pushNamed(StaticRouteName.cartScreen);
  }
  static void gotoLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamed(StaticRouteName.login);
  }
  static void gotoRegisterScreen(BuildContext context) {
    Navigator.of(context).pushNamed(StaticRouteName.register);
  }
  static void gotoMainScreen(BuildContext context) {
    Navigator.of(context).pushNamed(StaticRouteName.main);
  }
  static void showLoadingScreen(BuildContext context, Future<dynamic> whenClose, Function actionFunction) {
    Navigator.of(context).pushNamed(StaticRouteName.loading,arguments: {'whenclose':whenClose,'actionFunction':actionFunction});
  }
  static void gotoDoctorScreen(BuildContext context) {
    Navigator.of(context).pushNamed(StaticRouteName.doctorScreen);
  }
  static void gotoDoctorDetailScreen(BuildContext context, Doctor doctor) {
    Navigator.of(context).pushNamed(StaticRouteName.doctorDetails,arguments: {"doctor":doctor});
  }
  static void gotoPackageDetailScreen(BuildContext context, Package package) {
    Navigator.of(context).pushNamed(StaticRouteName.packageDetails,arguments: {"package":package});
  }
  static void gotoTestScreen(BuildContext context,{int category = 0}) {
    Navigator.of(context).pushNamed(StaticRouteName.testScreen,arguments: {"category":category});
  }
  static void bookingDetailsScreen(BuildContext context, Booking booking) {
    Navigator.of(context).pushNamed(StaticRouteName.bookingDetails, arguments: {"booking":booking});
  }
  static void goTopackageScreen(BuildContext context) {
    Navigator.of(context).pushNamed(StaticRouteName.allPackage);
  }
}
