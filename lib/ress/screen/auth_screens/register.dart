import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy/controllers/asset_controller.dart';
import 'package:pharmacy/controllers/auth_controller.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/services/route_controller.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';




class Register extends StatelessWidget {
Register({ Key? key }) : super(key: key);

final TextEditingController emailController = TextEditingController();
final TextEditingController mobileController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final GlobalKey<FormState> _key = GlobalKey<FormState>();

void nextPage(context)async{
  var args = {
   'email' : emailController.text, 
   'mobile' : mobileController.text, 
   'name' : nameController.text, 
   'password' : passwordController.text
  };
    AuthController.registerUser(context, _key, args);
  }

  @override
  Widget build(BuildContext context) {
    Constants constant = Constants(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
          padding: EdgeInsets.all( constant.screenWidth * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                 Image(
                    image: AssetController.doctorAsset,
                    fit: BoxFit.fill,
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    RichText(
                      text: TextSpan(
                        text: 'Hey,\n',
                        style: StaticStyle.textStyle(
                          fontSide: 10, 
                          height: constant.screenHeight * 0.005,
                          fontWeight: FontWeight.bold
                        ),
                        children: [
                          TextSpan(
                            text:'Register Now',
                            style: StaticStyle.textStyle(
                              fontSide: 10,
                              height: constant.screenHeight*0.005,
                              fontWeight: FontWeight.bold,
                              fontColor:StaticColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    InkWell(
                      onTap: (){
                        AppRouteController.gotoLoginScreen(context);
                      },
                      child: RichText(
                        text: TextSpan(
                          text:'Already have account /',
                          style: StaticStyle.textStyle(
                            fontSide: 5,
                            height: constant.screenHeight*0.005,
                            fontColor: StaticColors.muted
                          ),
                          children: [
                            TextSpan(
                              text:'  Login Now',
                              style: StaticStyle.textStyle(
                                fontSide: 5,
                                height: constant.screenHeight*0.005,
                                fontWeight: FontWeight.bold,
                                fontColor:StaticColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
                ),
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Your email',
                        ),
                      ),
                      TextFormField(
                        controller:nameController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Your name',
                        ),
                      ),
                      TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Your Mobile',
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                    onTap: (){
                      nextPage(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    width: constant.screenWidth,
                    height: constant.screenHeight * 0.05,
                    decoration: BoxDecoration(
                      color: StaticColors.primary,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text(
                        'Register',
                         style: StaticStyle.textStyle(
                           fontSide: 10, 
                           fontColor: Colors.white,
                           height: constant.screenHeight * 0.0025,
                           fontWeight:FontWeight.bold,
                         ),
                      ),
                    ),
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}