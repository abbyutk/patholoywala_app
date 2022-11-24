import 'dart:io';

import 'package:flutter/widgets.dart';
import '../config/app_config.dart';
import 'package:lottie/lottie.dart';

class AssetController{
  static const getLogo = AssetImage('assets/images/user/logo.png');
  static const doctorAsset = AssetImage('assets/images/user/login_doctor.png');
  static const firstOnBoarding = AssetImage('assets/images/user/on_boarding/1.png');
  static const secondOnBoarding = AssetImage('assets/images/user/on_boarding/2.png');
  static const socialGoogle = AssetImage('assets/images/user/social/google.png');
  static const socialLinkedin = AssetImage('assets/images/user/social/Linkedin-Icon.png');
  // static const shake = 'assets/images/icons/shake.png';

  static final loading = Lottie.asset('assets/anime/loading.json');

  static const dummyProfile = 'assets/images/user/empty/no_profile.jpg';

  static Image avatarImage(notifier,network){
    if(network){
      return Image.network("${AppConfig.mainUrl}/${notifier.value}",fit: BoxFit.cover,loadingBuilder: (c,v,h){
        return Image.asset(dummyProfile,fit: BoxFit.cover,width: 100,);
      },errorBuilder: (c,o,s){
        return Image.asset(dummyProfile,fit: BoxFit.cover,width: 100,);
      },);
    }
     if(notifier.value != AssetController.dummyProfile){
       return Image.file(File(notifier.value),fit: BoxFit.cover,);
     }
     return Image.asset(notifier.value);
  }
}