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



final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final ValueNotifier<bool> isLogged = ValueNotifier<bool>(true);

class Login extends StatelessWidget {
   Login({ Key? key }) : super(key: key);


void nextPage(context){
      AuthController.login(context, emailController.text, passwordController.text, isLogged);
}

    final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Constants constant = Constants(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: EdgeInsets.all( constant.screenWidth * 0.1),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              text:'Login Now',
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
                          AppRouteController.gotoRegisterScreen(context);
                        },
                        child: RichText(
                          text: TextSpan(
                            text:'If you are new /',
                            style: StaticStyle.textStyle(
                              fontSide: 5,
                              height: constant.screenHeight*0.005,
                              fontColor: StaticColors.muted
                            ),
                            children: [
                              TextSpan(
                                text:'  Create new',
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
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Your email',
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
                      if(isLogged.value){
                        nextPage(context);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: constant.screenWidth,
                      height: constant.screenHeight * 0.05,
                      decoration: BoxDecoration(
                        color: !isLogged.value ? StaticColors.muted : StaticColors.primary,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text(
                          'Login',
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