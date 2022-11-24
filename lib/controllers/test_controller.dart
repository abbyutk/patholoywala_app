import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:pharmacy/config/app_config.dart';
import 'package:pharmacy/controllers/auth_controller.dart';
import 'package:pharmacy/helpers/console.dart';
import 'package:pharmacy/helpers/preference_manager.dart';
import 'package:pharmacy/ress/model/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/ress/model/booking.dart';
import 'package:pharmacy/ress/model/test.dart';
import 'package:pharmacy/ress/model/test_category_model.dart';

class TestController{

  static Future<List<Test>> getFeaturedTests(BuildContext context)async{
      const url = "${AppConfig.host}/featured/tests";
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
      );
      var result = ApiResponse.fromJson(jsonDecode(response.body));
      Console.log(result.data);
      List<Test> tests = [] ;
      if(AuthController.checkAuthentication(result, context)){
        // Notify(
        //   context: context,
        //   type:result.success ? 'success' : 'error',
        //   message: result.message,
        //   messageType: Notify.APINOTIFICATION
        // );
       tests = result.success ? (result.data["tests"] as List).map<Test>((e) => Test.fromJson(e)).toList() : [];
      }
        return tests;
  }
  static Future<List<Test>> getTests(BuildContext context)async{
      const url = "${AppConfig.host}/tests";
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
      );
      var result = ApiResponse.fromJson(jsonDecode(response.body));
      Console.log(result.data);
      List<Test> tests = [] ;
      if(AuthController.checkAuthentication(result, context)){
        // Notify(
        //   context: context,
        //   type:result.success ? 'success' : 'error',
        //   message: result.message,
        //   messageType: Notify.APINOTIFICATION
        // );
       tests = result.success ? (result.data["tests"] as List).map<Test>((e) => Test.fromJson(e)).toList() : [];
      }
        return tests;
  }
  
  static Future<List<Test>> getTestsByCategory(BuildContext context, int category)async{
      var url = "${AppConfig.host}/category/test?category_id=$category";
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
      );
      var result = ApiResponse.fromJson(jsonDecode(response.body));
      Console.log(result.data);
      List<Test> tests = [] ;
      if(AuthController.checkAuthentication(result, context)){
        // Notify(
        //   context: context,
        //   type:result.success ? 'success' : 'error',
        //   message: result.message,
        //   messageType: Notify.APINOTIFICATION
        // );
       tests = result.success ? (result.data["tests"] as List).map<Test>((e) => Test.fromJson(e)).toList() : [];
      }
        return tests;
  }
  
  static Future<List<TestCategory>> getCategories(BuildContext context)async{
      const url = "${AppConfig.host}/categories";
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
      );
      var result = ApiResponse.fromJson(jsonDecode(response.body));
      Console.log(result.data);
      List<TestCategory> tests = [] ;
      if(AuthController.checkAuthentication(result, context)){
        // Notify(
        //   context: context,
        //   type:result.success ? 'success' : 'error',
        //   message: result.message,
        //   messageType: Notify.APINOTIFICATION
        // );
       tests = result.success ? (result.data["categories"] as List).map<TestCategory>((e) => TestCategory.fromJson(e)).toList() : [];
      }
        return tests;
  }
  static Future<List<Booking>> getBookings(BuildContext context)async{
      const url = "${AppConfig.host}/get/all/orders";
      final response = await http.post(
        Uri.parse(url),
        headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
      );
      var result = ApiResponse.fromJson(jsonDecode(response.body));
      Console.log(result.data);
      List<Booking> tests = [] ;
      if(AuthController.checkAuthentication(result, context)){
        // Notify(
        //   context: context,
        //   type:result.success ? 'success' : 'error',
        //   message: result.message,
        //   messageType: Notify.APINOTIFICATION
        // );
       tests = result.success ? (result.data["orders"] as List).map<Booking>((e) => Booking.fromJson(e)).toList() : [];
      }
        return tests;
  }

}