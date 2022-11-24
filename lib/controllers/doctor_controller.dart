import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:pharmacy/config/app_config.dart';
import 'package:pharmacy/controllers/auth_controller.dart';
import 'package:pharmacy/helpers/console.dart';
import 'package:pharmacy/helpers/preference_manager.dart';
import 'package:pharmacy/ress/model/api_response.dart';
import 'package:pharmacy/ress/model/doctor.dart';
import 'package:http/http.dart' as http;

class DoctorController{

  static Future<List<Doctor>> getFeaturedDoctors(BuildContext context)async{
      const url = "${AppConfig.host}/featured/doctors";
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
      );
      var result = ApiResponse.fromJson(jsonDecode(response.body));
      Console.log(result.data);
      List<Doctor> doctors = [] ;
      if(AuthController.checkAuthentication(result, context)){
        // Notify(
        //   context: context,
        //   type:result.success ? 'success' : 'error',
        //   message: result.message,
        //   messageType: Notify.APINOTIFICATION
        // );
       doctors = result.success ? (result.data["doctors"] as List).map<Doctor>((e) => Doctor.fromJson(e)).toList() : [];
      }
        return doctors;
  }
  static Future<List<Doctor>> getDoctors(BuildContext context)async{
      const url = "${AppConfig.host}/doctors";
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
      );
      var result = ApiResponse.fromJson(jsonDecode(response.body));
      Console.log(result.data);
      List<Doctor> doctors = [] ;
      if(AuthController.checkAuthentication(result, context)){
        // Notify(
        //   context: context,
        //   type:result.success ? 'success' : 'error',
        //   message: result.message,
        //   messageType: Notify.APINOTIFICATION
        // );
       doctors = result.success ? (result.data["doctors"] as List).map<Doctor>((e) => Doctor.fromJson(e)).toList() : [];
      }
        return doctors;
  }

}