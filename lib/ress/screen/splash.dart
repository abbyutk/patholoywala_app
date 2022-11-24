import 'package:flutter/widgets.dart';
import 'package:pharmacy/ress/model/user.dart';
import 'package:pharmacy/ress/services/route_controller.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import '../../controllers/profile_controller.dart';
import '../../controllers/asset_controller.dart';
import '../../helpers/constants.dart';
import '../../helpers/data_manager.dart';
import '../../helpers/preference_manager.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  late SharedPreferences preference ; 

 @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => removeSplashScreen());
  }

  void removeSplashScreen() async {
    preference = await SharedPreferences.getInstance();
    // if(preference.getBool(PreferenceManager.IS_FIRST_TIME)??true){
    //   await Future.delayed(const Duration(seconds: 2));
    //   AppRouteController.gotoLoginScreen(context);
    // }else {
      try{
        var token = preference.getString(PreferenceManager.AUTHORIZATION_TOKEN);
        if(token != null && token != '') {
          User user = await ProfileController.getProfile(context);
          DataManager.saveUserData(user);
          DataManager.token = await PreferenceManager.getToken(context);
          AppRouteController.gotoMainScreen(context);
        }else {
          AppRouteController.gotoLoginScreen(context);
        }
      }catch(e){
        AppRouteController.gotoLoginScreen(context);
      }
    // }
  }

  @override
  Widget build(BuildContext context) {
    Constants constant = Constants(context);

    return Container(
      color: StaticColors.primary,
      child: Center(
        child: Container(
          width: constant.screenWidth * 0.5,
          height: constant.screenHeight * 0.2,
          padding: EdgeInsets.only(left:constant.screenWidth * 0.1, right:constant.screenWidth * 0.1),
          decoration: BoxDecoration(
            color: StaticColors.backgroundColor,
            shape: BoxShape.circle
          ),
          child: const Center(
            child: Image(
              image: AssetController.getLogo,
            ),
          ),
        ),
      ),
    );
  }
}