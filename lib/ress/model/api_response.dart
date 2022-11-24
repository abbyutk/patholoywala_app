
import 'package:pharmacy/helpers/console.dart';

class ApiResponse{
  final Map<String,dynamic>data;
  final bool success; 
  final int code;
  final Map<String,dynamic> message;
  ApiResponse({
    required this.data,
    required this.success,
    required this.code,
    required this.message,
  });
  static ApiResponse fromJson(final jsonData){
    Map<String,dynamic> data = {};
    try{
      data = jsonData["result"];
    }catch(e){
      Console.log(e);
      data = {};
    }
    var response = ApiResponse(
      data: data,
      message: jsonData["error"]["message"]??{},
      code: jsonData["error"]["code"]??400,
      success: jsonData["success"]??false,
    );
    return response;
  }
}