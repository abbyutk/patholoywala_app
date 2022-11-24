import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:pharmacy/ress/model/api_response.dart';

import '../config/app_config.dart';
import '../helpers/console.dart';
import '../helpers/notify.dart';
import '../helpers/preference_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DbConnector{
  static Future<ApiResponse> generateLoginRequest(String email) async {
    const url = "${AppConfig.host}/auth/login";
    final response = await http.post(
      Uri.parse(url),
      body: {
        "email": email,
        "type" : "0",
        "reason": "2"
        // "mobile": user.mobile,
        // "password": user.password,
      },
      headers: AppConfig.getApiHeader(null),
    );
    // Console.log(response.body);
    return ApiResponse.fromJson(jsonDecode(response.body));
  }
  static Future<ApiResponse> verifyLoginRequest(String email, String code) async {
    const url = "${AppConfig.host}/auth/login/verify";
    final response = await http.post(
      Uri.parse(url),
      body: {
        "email": email,
        "type" : "0",
        "reason": "2",
        "code"  : code
        // "mobile": user.mobile,
        // "password": user.password,
      },
      headers: AppConfig.getApiHeader(null),
    );
    // Console.log(response.body);
    return ApiResponse.fromJson(jsonDecode(response.body));
  }
  static Future<ApiResponse> loginWithPassword(String email, String password) async {
    const url = "${AppConfig.host}/login";
    final response = await http.post(
      Uri.parse(url),
      body: {
        "email": email,
        "password" : password,
        // "mobile": user.mobile,
        // "password": user.password,
      },
      headers: AppConfig.getApiHeader(null),
    );
    return ApiResponse.fromJson(response.body);
  }
  // static Future<Map<String,dynamic>> getLinkedinToken(String code) async {
  static Future<ApiResponse> getLinkedinToken(String code) async {
    const url = "${AppConfig.host}/auth/login/linkedin";
    String accessCode = '';
    bool success = false;
    final response = await http.post(Uri.parse(url),body: {
      'token': code
    });
    var token = ApiResponse.fromJson(jsonDecode(response.body));
    return token;
    // final response = await http.post(
    //   Uri.parse('https://www.linkedin.com/oauth/v2/accessToken'),
    //   body: {
    //     'grant_type':'authorization_code',
    //     'client_id':AppConfig.LINKEDIN_CLIENT_ID,
    //     'client_secret':AppConfig.LINKEDIN_SECRET,
    //     'redirect_uri':AppConfig.LINKED_REDIRECT_URL,
    //     'code':code,
    //   },
    //   // headers: AppConfig.getApiHeader(null),
    // );
    // if(response.statusCode == 200){
    //   accessCode = jsonDecode(response.body)['access_token'];
    //   final token = await http.post(
    //     Uri.parse('${AppConfig.host}/auth/login/linkedin'),
    //     body: {
    //       'token':code,
    //     },

    //     // headers: AppConfig.getApiHeader(null),
    //   );
    //   Console.log(token.body);
    // }else{
    //   Console.log(response);
    // }
    // return {'code':accessCode,'success':success};
  }
  static Future<ApiResponse> register(Map<String,String> args) async {
    const url = "${AppConfig.host}/register";
    final response = await http.post(
      Uri.parse(url),
      body: args,
      headers: AppConfig.getApiHeader(null),
    );
    // Console.log(response.body);
    return ApiResponse.fromJson(jsonDecode(response.body));
  }
  static Future<ApiResponse> logout(PreferenceManager manager, BuildContext context) async {
    const url = "${AppConfig.host}/logout";
    final response = await http.get(
      Uri.parse(url),
      headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
    );
    Console.log(response.body,p: true);
    return ApiResponse.fromJson(jsonDecode(response.body));
  }

}