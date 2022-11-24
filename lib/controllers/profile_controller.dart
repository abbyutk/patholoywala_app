import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/config/app_config.dart';
import 'package:pharmacy/controllers/auth_controller.dart';
import 'package:pharmacy/helpers/console.dart';
import 'package:pharmacy/helpers/data_manager.dart';
import 'package:pharmacy/helpers/notify.dart';
import 'package:pharmacy/helpers/preference_manager.dart';
import 'package:pharmacy/ress/model/api_response.dart';
import 'package:pharmacy/ress/model/user.dart';

class ProfileController{
  // static void captureImage(ValueNotifier<String> imageNotifier, bool network)async{
  //   final ImagePicker imagePicker = ImagePicker();
  //   final XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
  //   final path ="";
    // final path = image!=null?image.path : AssetController.dummyProfile;
  //   network = false;
  //   imageNotifier.value = path;
  // }
  static void updateProfile(BuildContext context, GlobalKey<FormState> _formKey, Map<String,String> args, String path)async{
    if(_formKey.currentState!.validate()){
      var url = Uri.parse("${AppConfig.host}/update/profile");
      final request = http.MultipartRequest('POST',url);
      try{
        request.files.add(await http.MultipartFile.fromPath("image", path));
      }catch(e){
        Console.log('ProfileController:34:unable to fetch image');
      }
      request.headers.addAll(AppConfig.getApiHeader(await PreferenceManager.getToken(context)));
      request.fields.addAll(args);
      // final response = await http.post(
      //   Uri.parse(url),
      //   body: args,
      //   headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
      // );
      final response = await request.send();
      response.stream.transform(utf8.decoder).listen((event) { 
        Console.log(event);
        var result = ApiResponse.fromJson(jsonDecode(event));
        if(AuthController.checkAuthentication(result, context)){
          Notify(
            context: context,
            type:result.success ? 'success' : 'error',
            message: result.message,
            messageType: Notify.APINOTIFICATION
          );
          if(result.success) {
            ProfileController.getProfile(context).then((value){
              getProfile(context);
              // AppRouteController.main(context);
            });
          }
        }
      });
    }
  }
  static Future<User> getProfile(BuildContext context)async{
      const url = "${AppConfig.host}/get/profile";
      final response = await http.post(
        Uri.parse(url),
        headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
      );
      Console.log(response.body);
      var result = ApiResponse.fromJson(jsonDecode(response.body));
      var user ;
      if(AuthController.checkAuthentication(result, context)){
        // Notify(
        //   context: context,
        //   type:result.success ? 'success' : 'error',
        //   message: result.message,
        //   messageType: Notify.APINOTIFICATION
        // );
       user = result.success ? User.fromJson(result.data['user']) : User.dummyProfile();
      }
        // DataManager.saveUserData(user);
        DataManager.user = user;
        return user;
  }
}