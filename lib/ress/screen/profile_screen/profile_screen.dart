import 'package:pharmacy/config/app_config.dart';
import 'package:pharmacy/controllers/asset_controller.dart';
import 'package:pharmacy/controllers/auth_controller.dart';
import 'package:pharmacy/controllers/profile_controller.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/helpers/data_manager.dart';
import 'package:pharmacy/ress/model/user.dart';
import 'package:pharmacy/ress/screen/app_widget/buttons.dart';
import 'package:pharmacy/ress/screen/app_widget/form.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

final GlobalKey<FormState> key = GlobalKey<FormState>();

final ValueNotifier<String> imageNotifier = ValueNotifier(AssetController.dummyProfile);
final TextEditingController passwordController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController mobileController = TextEditingController();
final TextEditingController speciltyController = TextEditingController();
final TextEditingController openController = TextEditingController();
final TextEditingController closeController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController bioController = TextEditingController();
bool first = true;

class _ProfileState extends State<Profile> {

  void doNext(context){
      var args = {
       'name' : nameController.text, 
       'email' : emailController.text, 
       'password' : passwordController.text,
       'mobile':mobileController.text,
      //  'image':imageNotifier.value != AssetController.dummyProfile ? imageNotifier.value : '',
      };
      ProfileController.updateProfile(context, key, args, (imageNotifier.value != AssetController.dummyProfile ? imageNotifier.value : ''));
    }

    void pickTime(bool which){
      DatePicker.showTimePicker(
        context,
        onConfirm: (v){
          var controller = which ? openController : closeController ;
          controller.text = "${v.hour}:${v.minute}:${v.second}";
        }
      );
    }

  @override
  Widget build(BuildContext context) {
    Constants constant = Constants(context);
    User user = DataManager.user;
    if(first){
      nameController.text = user.name;
      emailController.text = user.email;
      mobileController.text = user.mobile;
      first = false;
    }
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(constant.screenHeight * 0.3),
          child: Container(
            decoration: BoxDecoration(
              color: StaticColors.primary,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // BackButton(),
                SizedBox(),
                SizedBox(
                  height: constant.screenHeight * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //   width: constant.screenWidth * 0.2,
                      //   height: constant.screenWidth * 0.2,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: StaticColors.mutedColor,
                      //     // image: DecorationImage(
                      //     //   fit: BoxFit.fill,
                      //     //   image: NetworkImage(
                      //     //     "${AppConfig.mainUrl}/${user.image}",
                      //     //   ),
                      //     // ),
                      //   ),
                      // ),
                      Text(
                        user.name,
                        style: constant.textTheme.headline2?.copyWith(
                          fontSize: 20,
                          color: StaticColors.backgroundColor,
                        ),
                      ),
                      Text(
                        user.mobile,
                        style: constant.textTheme.headline2?.copyWith(
                          fontSize: 20,
                          color: StaticColors.backgroundColor,
                        ),
                      ),
                      Text(
                        user.email,
                        style: constant.textTheme.headline2?.copyWith(
                          fontSize: 20,
                          color: StaticColors.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(onPressed: (){
                  AuthController.logout(context);
                }, icon: const Icon(Icons.logout)),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Update details',
              style: constant.textTheme.headline4?.copyWith(
                fontSize: 25,
              ),
            ),
            Form(
              key: key,
                child: Column(
                        children: [
                          FormControl.input(
                            controller: nameController,
                            context: context, 
                            placeholder: 'Enter name', 
                            constant: constant, 
                            type: TextInputType.text, 
                            validator: (value){
                              if(!FormControl.emptyValidator(value)) return 'Name is mandatory' ; 
                            },
                          ),
                          FormControl.input(
                            controller: emailController,
                            context: context, 
                            placeholder: 'Enter email',
                            enabled: false, 
                            constant: constant, 
                            type: TextInputType.text, 
                            validator: (value){
                              if(!FormControl.emptyValidator(value)) return 'Email is mandatory' ; 
                            },
                          ),
                          FormControl.input(
                            controller: mobileController,
                            context: context,
                            placeholder: 'Enter mobile', 
                            constant: constant, 
                            type: TextInputType.text,
                            validator: (value){
                              if(!FormControl.emptyValidator(value)) return 'Mobile is mandatory' ; 
                            },
                          ),
                          FormControl.input(
                            controller: passwordController,
                            context: context, 
                            placeholder: 'Enter password', 
                            constant: constant, 
                            type: TextInputType.text, 
                            obscure: true,
                            validator: (value){
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Buttons.smallButton(context, constant, 'Update', doNext),
                  ],
                ),
        ),
      ),
    );
  }
}