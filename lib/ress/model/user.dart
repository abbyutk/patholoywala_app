import 'package:pharmacy/controllers/asset_controller.dart';
import 'package:pharmacy/helpers/console.dart';

class User{
  final String name, mobile, email, id;
  User({
    required this.name,
    required this.email,
    // required this.image,
    required this.mobile,
    required this.id,
    // required this.user_id,
  });
  static User fromJson(final jsonData){

    Console.log(jsonData);
    return User(
       name:jsonData['name']??'',
      email:jsonData['email']??'',
      mobile:jsonData['mobile']??'',
      // image:jsonData['detail']['doctor_image']??AssetController.dummyProfile,
      id: "${jsonData['id'] ?? ''}",
    );
  }
  static User dummyProfile(){

    return User(
      name:'',
      email:'',
      mobile:'',
      id: '',
    );
  }
}