import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:pharmacy/config/app_config.dart';
import 'package:pharmacy/controllers/auth_controller.dart';
import 'package:pharmacy/helpers/console.dart';
import 'package:pharmacy/helpers/preference_manager.dart';
import 'package:pharmacy/ress/model/api_response.dart';
import 'package:pharmacy/ress/model/appointment.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../helpers/notify.dart';
import '../ress/services/route_controller.dart';

class AppointmentController{
  static Future<List<Appointment>> getAppointment(BuildContext context)async{
      const url = "${AppConfig.host}/appointments";
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
      );
      Console.log(response.body);
      var result = ApiResponse.fromJson(jsonDecode(response.body));
      List<Appointment> appointments = [] ;
      if(AuthController.checkAuthentication(result, context)){
        // Notify(
        //   context: context,
        //   type:result.success ? 'success' : 'error',
        //   message: result.message,
        //   messageType: Notify.APINOTIFICATION
        // );
       appointments = result.success ? (result.data["appointments"] as List).map<Appointment>((e) => Appointment.fromJson(e)).toList() : [];
      }
        return appointments;
  }
  static void bookAppointment(BuildContext context, Map<String,String> args)async{
      const url = "${AppConfig.host}/book/appointment";
      final response = await http.post(
        Uri.parse(url),
        headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
        body: args,
      );

      Console.log("respnses============================");
      Console.log(response.body);
      var result = ApiResponse.fromJson(jsonDecode(response.body));
      if(AuthController.checkAuthentication(result, context)){
        Notify(
          context: context,
          type:result.success ? 'success' : 'error',
          message: result.message,
          messageType: Notify.APINOTIFICATION
        );
        if(result.success && args['payment_method']== "0") AppRouteController.goBack(context);
        else{
          var _razorpay = Razorpay();
          _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse paymentResponse)async{
            final resp = await http.post(
              Uri.parse("${AppConfig.host}/appointment/update"),
              headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
              body: {
                "receipt":result.data['receipt'],
                "razor":json.encode({
                  "razorpay_payment_id": paymentResponse.paymentId,
                  "razorpay_order_id": paymentResponse.orderId,
                  "razorpay_signature": paymentResponse.signature,
                }),
              },
            );
            Console.log(resp.body);
            var res = ApiResponse.fromJson(jsonDecode(resp.body));
            Notify(
              context: context,
              type:res.success ? 'success' : 'error',
              message: res.message,
              messageType: Notify.APINOTIFICATION
            );
          });
          _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse paymentResponse){
            Notify(
              context: context,
              type:'error',
              message: 'Payment Failed. Please try again',
              messageType: Notify.TEXTNOTIFICATION
            );
          });
          _razorpay.open({
            "key": "rzp_test_0pDhN18Binxi6i", 
            "amount": result.data['amount'], 
            "currency": result.data['currency'],
            "name": "Pathologywala",
            "description": "Payment for your booking",
            "order_id": result.data['id'],
            "notes": {
                "office": "Bhopal"
            },
            "theme": {
                "color": "#c34764"
            } 
          });
        }
      }
  }
}