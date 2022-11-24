import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/style/static_colors.dart';

class FormControl{
  static Widget input({
    required BuildContext context, 
    required String placeholder, 
    required Constants constant, 
    TextInputType type=TextInputType.text, 
    bool enabled = true,
    required Function validator,
    required TextEditingController controller,
    bool obscure = false
    }){
    return Container(
        margin: EdgeInsets.all(constant.screenHeight * 0.02),
        padding: EdgeInsets.only(left:constant.screenHeight * 0.02,right: constant.screenHeight * 0.02),
        decoration: BoxDecoration(
          color: StaticColors.backgroundColor,
          borderRadius: BorderRadius.circular(constant.screenHeight * 0.02)
        ),
        child: TextFormField(
          controller: controller,
          // key:emailKey,
          enabled: enabled,
          keyboardType:type,
          obscureText: obscure,
          validator: (value){
            return validator(value);
          },
          // style: AppTextStyle.placeholderText(constant),
          decoration: InputDecoration(
            hintText: placeholder,
          ),
        ),
      );
  }
  static Widget inputPlain({
    required BuildContext context, 
    required String placeholder, 
    required Constants constant, 
    TextInputType type=TextInputType.text, 
    required Function validator,
    required TextEditingController controller,
    bool obscure = false,
    bool enabled = true,
    }){
    return Container(
        margin: EdgeInsets.all(constant.screenHeight * 0.02),
        padding: EdgeInsets.only(left:constant.screenHeight * 0.02,right: constant.screenHeight * 0.02),
        decoration: BoxDecoration(
          color: StaticColors.muted,
          borderRadius: BorderRadius.circular(constant.screenHeight * 0.01)
        ),
        child: TextFormField(
          controller: controller,
          enabled: enabled,
          // key:emailKey,
          keyboardType:type,
          obscureText: obscure,
          validator: (value){
            return validator(value);
          },
          decoration: InputDecoration(
            hintText: placeholder,
          ),
        ),
      );
  }

  static bool emailValidator(String value){
    return EmailValidator.validate(value);
    // return false;
  }

  static bool emptyValidator(String value){
    return value.isNotEmpty;
  }
}