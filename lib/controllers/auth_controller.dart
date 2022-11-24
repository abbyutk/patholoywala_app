import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/config/app_config.dart';
import 'package:pharmacy/controllers/db_connector.dart';
import 'package:pharmacy/controllers/profile_controller.dart';
import 'package:pharmacy/helpers/console.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/helpers/data_manager.dart';
import 'package:pharmacy/helpers/notify.dart';
import 'package:pharmacy/helpers/preference_manager.dart';
import 'package:pharmacy/ress/model/api_response.dart';
import 'package:pharmacy/ress/model/user.dart';
import 'package:pharmacy/ress/screen/app_widget/loading.dart';
import 'package:pharmacy/ress/services/route_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController{
  // static sendOTP(BuildContext context, String mobile, ValueNotifier<bool> otpListner, int code)async{
  //    otpListner.value = false;
  //     const url = "${AppConfig.host}/generate/otp";
  //     final responseBody = await http.post(
  //       Uri.parse(url),
  //       body: {
  //         "phone": mobile,
  //         "code" : code.toString(),
  //         // "reason": "2"
  //         // "mobile": user.mobile,
  //         // "password": user.password,
  //       },
  //       headers: AppConfig.getApiHeader(null),
  //     );
  //     // Console.log(responseBody.body);
  //     ApiResponse response = ApiResponse.fromJson(jsonDecode(responseBody.body));
  //     Notify(
  //         context: context,
  //         type: response.success ? 'success' : 'error',
  //         message: response.message,
  //         messageType: Notify.APINOTIFICATION
  //       );
  //       otpListner.value = true;
  //       // Navigator.pop(context);
  //       if(response.success)AppRouteController.gotoVerifyCode(context, mobile, code);
  // }

  // static verifyOTP(BuildContext context, String otp, String mobile, int code)async{
  //   Constants constant = Constants(context);
  //   const url = "${AppConfig.host}/verify/otp";
  //   final responseData = await http.post(
  //     Uri.parse(url),
  //     body: {
  //       "phone": mobile,
  //       "otp"  : otp,
  //       "code" : code.toString(),
  //       // "mobile": user.mobile,
  //       // "password": user.password,
  //     },
  //     headers: AppConfig.getApiHeader(null),
  //   );
  //   ApiResponse response = ApiResponse.fromJson(jsonDecode(responseData.body));
  //   // AppRouteController.showLoadingScreen(context, response, (value)async{
  //     Notify(
  //       context: context,
  //       type: response.success ? 'success' : 'error',
  //       message: response.message,
  //       messageType: Notify.APINOTIFICATION
  //     );
  //     //if userdetail is null pass to verify screen else goto profile.

  //       var token = response.data['token'];
  //     // if(response.success){
  //       var preferences = await SharedPreferences.getInstance();
  //       var manager = PreferenceManager(preferences);
  //       // if(detail == null){
  //         //   AppRouteController.gotoAccountVerifyPage(context);
  //         // }else {
  //           // }
  //     // }
  //     if(token != null){
  //       manager.token = token;
  //       AppRouteController.gotoBookingMainScreen(context);
  //     }else{
  //       AppRouteController.gotoDetailsClientScreen(context,code:code,mobile:mobile);
  //     }
  // }

   static login(BuildContext context, String email, String password, ValueNotifier<bool> isLogged)async{
     isLogged.value = false;
      const url = "${AppConfig.host}/login";
      final response = await http.post(
        Uri.parse(url),
        body: {
          "email": email,
          "password" : password,
          // "reason": "2"
          // "mobile": user.mobile,
          // "password": user.password,
        },
        headers: AppConfig.getApiHeader(null),
      );
      
    //  ApiResponse response = ApiResponse.fromJson(jsonDecode(responseBody.body));
    showDialog(context: context, builder: (context){
      return Loading();
    });
    ApiResponse result = ApiResponse.fromJson(jsonDecode(response.body));
      Notify(
        context: context,
        type: result.success ? 'success' : 'error',
        message: result.message,
        messageType: Notify.APINOTIFICATION
      );
      //if userdetail is null pass to verify screen else goto profile.
      isLogged.value = true;
        var token = result.data['token'];
      // if(response.success){
        var preferences = await SharedPreferences.getInstance();
        var manager = PreferenceManager(preferences);
        // if(detail == null){
          //   AppRouteController.gotoAccountVerifyPage(context);
          // }else {
            // }
        if(token != null){
          manager.token = token;
          User user = await ProfileController.getProfile(context);
          DataManager.saveUserData(user);
          AppRouteController.gotoMainScreen(context);
        }
  }

  static registerUser(BuildContext context, GlobalKey<FormState> _formKey, Map<String,String> args)async{
    if(_formKey.currentState!.validate()){
      var result = await DbConnector.register(args);
      Notify(
        context: context,
        type:result.success ? 'success' : 'error',
        message: result.message,
        messageType: Notify.APINOTIFICATION
      );
      if(result.success)AppRouteController.gotoLoginScreen(context);
    }else{
      Notify(
        context: context,
        type: 'error',
        message: 'Something went wrong...',
        messageType: Notify.TEXTNOTIFICATION
      );
    }
  }
  static logout(BuildContext context)async{
    var _preference = PreferenceManager(await SharedPreferences.getInstance());
    var result = await DbConnector.logout(_preference,context);
      if(AuthController.checkAuthentication(result, context)){
        Notify(
          context: context,
          type:result.success ? 'success' : 'error',
          message: result.message,
          messageType: Notify.APINOTIFICATION
        );
        if(result.success){
          _preference.logout();
          AppRouteController.gotoLoginScreen(context);
        }
      }
  }

  static logoutOffline(BuildContext context)async{
    var _preference = PreferenceManager(await SharedPreferences.getInstance());
    _preference.logout();
    AppRouteController.gotoLoginScreen(context);
  }

  static checkAuthentication(ApiResponse result, BuildContext context){
    bool au = result.data['unauthenticated']??false;
    if(au)  AuthController.logoutOffline(context);
    return !au;
  }
}