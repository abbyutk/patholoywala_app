import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:pharmacy/config/app_config.dart';
import 'package:pharmacy/controllers/auth_controller.dart';
import 'package:pharmacy/helpers/console.dart';
import 'package:pharmacy/helpers/notify.dart';
import 'package:pharmacy/helpers/preference_manager.dart';
import 'package:pharmacy/ress/model/api_response.dart';
import 'package:pharmacy/ress/model/cart_model.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy/ress/model/test_lab.dart';
import 'package:pharmacy/ress/services/route_controller.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartController{

  static Future<List<CartProduct>> getCart(BuildContext context)async{
      const url = "${AppConfig.host}/cart/get";
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
      );
      var result = ApiResponse.fromJson(jsonDecode(response.body));
      Console.log(result.data);
      List<CartProduct> items = [] ;
      if(AuthController.checkAuthentication(result, context)){
        // Notify(
        //   context: context,
        //   type:result.success ? 'success' : 'error',
        //   message: result.message,
        //   messageType: Notify.APINOTIFICATION
        // );
       items = result.success ? (result.data['items'] as List).map<CartProduct>((e) => CartProduct.fromJson(e)).toList() : [];
      }
        return items;
  }
  static Future<List<CartProduct>> getBookingItems(BuildContext context,String id)async{
      const url = "${AppConfig.host}/get/orders/id";
      final response = await http.post(
        Uri.parse(url),
        headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
        body: {"order":id}
      );
      var result = ApiResponse.fromJson(jsonDecode(response.body));
      Console.log(result.data);
      List<CartProduct> items = [] ;
      if(AuthController.checkAuthentication(result, context)){
        // Notify(
        //   context: context,
        //   type:result.success ? 'success' : 'error',
        //   message: result.message,
        //   messageType: Notify.APINOTIFICATION
        // );
       items = result.success ? (result.data['details'] as List).map<CartProduct>((e) => CartProduct.fromJson(e,booked: true)).toList() : [];
      }
        return items;
  }
  static Future<List<TestLab>> getLab(BuildContext context)async{
      const url = "${AppConfig.host}/labs";
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
      );
      var result = ApiResponse.fromJson(jsonDecode(response.body));
      Console.log(result.data);
      List<TestLab> labs = [] ;
      if(AuthController.checkAuthentication(result, context)){
        // Notify(
        //   context: context,
        //   type:result.success ? 'success' : 'error',
        //   message: result.message,
        //   messageType: Notify.APINOTIFICATION
        // );
       labs = result.success ? (result.data['labs'] as List).map<TestLab>((e) => TestLab.fromJson(e)).toList() : [];
      }
        return labs;
  }
  static void addToCart(BuildContext context, String id)async{
      var url = "${AppConfig.host}/cart/add?id=$id";
      final response = await http.get(
        Uri.parse(url),
        headers: AppConfig.getApiHeader(await PreferenceManager.getToken(context)),
      );
      Console.log(response.body);
      var result = ApiResponse.fromJson(jsonDecode(response.body));
      List<CartProduct> items = [] ;
      if(AuthController.checkAuthentication(result, context)){
        Notify(
          context: context,
          type:result.success ? 'success' : 'error',
          message: result.message,
          messageType: Notify.APINOTIFICATION
        );
      }
  }

  static void createOrder(BuildContext context, Map<String,String> args)async{
      const url = "${AppConfig.host}/store/create-order";
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
              Uri.parse("${AppConfig.host}/order-callback"),
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