import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pharmacy/controllers/cart_controller.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/model/cart_model.dart';
import 'package:pharmacy/ress/model/test_lab.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/style/static_colors.dart';

import '../app_widget/custom_appbar.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final TextEditingController addressController = TextEditingController(text:kDebugMode ? "Black valley":"");
  final TextEditingController landmarkController = TextEditingController(text:kDebugMode ? "The wall":"");
  final TextEditingController dateController = TextEditingController(text:kDebugMode ? "2022/12/12":"");
  final TextEditingController timeController = TextEditingController(text:kDebugMode ? "12:20:10":"");
  final TextEditingController pincodeController = TextEditingController(text:kDebugMode ? "123456":"");
  final ValueNotifier<int> paymentNotifier = ValueNotifier(1);
  final ValueNotifier<int> labNotifier = ValueNotifier(0);
  List<TestLab> labs = [];


  void checkout(context){
    Map<String,String> args = {
            'collection_address':addressController.text,
            'collection_landmark':landmarkController.text,
            'collection_pincode':pincodeController.text,
            'collection_date':dateController.text,
            'collection_time': timeController.text,   
            'payment_method' : paymentNotifier.value.toString(),
            'odt':"0",
            'lab':"${labs[labNotifier.value].id}"
          };
    CartController.createOrder(context, args);
  }

  void pickTime(context,bool which){
      which ? DatePicker.showTimePicker(
        context,
        onConfirm: (v){
          timeController.text = "${v.hour}:${v.minute}:${v.second}";
        }
      )
      : DatePicker.showDatePicker(
        context,
        onConfirm: (v){
          dateController.text = "${v.year}/${v.month}/${v.day}";
        }
      );
    }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final Constants constant = Constants(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          backgroundColor: StaticColors.primary,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: constant.screenWidth,
                  height: constant.screenHeight * 0.05,
                  color: StaticColors.primary,
                  child: Center(
                    child: Text(
                      'Add sample collection address,date & time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: StaticColors.backgroundColor
                      ),
                    ),
                  ),
                ),
                Container(
                  width: constant.screenWidth,
                  height: constant.screenHeight * 0.1,
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      label: Text("Collection address"),
                    ),
                  ),
                ),
                Container(
                  width: constant.screenWidth,
                  height: constant.screenHeight * 0.1,
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: landmarkController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      label: Text("Collection landmark"),
                    ),
                  ),
                ),
                Container(
                  width: constant.screenWidth,
                  height: constant.screenHeight * 0.1,
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: pincodeController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      label: Text("Collection Pincode"),
                    ),
                  ),
                ),
                InkWell(
                  onTap: ()=>pickTime(context,false),
                  child: Container(
                    width: constant.screenWidth,
                    height: constant.screenHeight * 0.1,
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: dateController,
                      enabled: false,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        label: Text("Collection date"),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: ()=>pickTime(context,true),
                  child: Container(
                    width: constant.screenWidth,
                    height: constant.screenHeight * 0.1,
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: timeController,
                      enabled: false,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        label: Text("Collection time"),
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: paymentNotifier,
                  builder: (context, value, child){
                    return DropdownButtonFormField(
                      onChanged: (value){
                        paymentNotifier.value = int.parse(value.toString());
                      },
                      value: paymentNotifier.value,
                      items: [
                        DropdownMenuItem(child: Text("Online Payment"), value: 1,),
                        DropdownMenuItem(child: Text("Cash on collection"), value: 0,)
                      ],
                    );
                  },
                ),
                Container(
                  width: constant.screenWidth,
                  height: constant.screenHeight * 0.05,
                  color: StaticColors.primary,
                  child: Center(
                    child: Text(
                      'Tests',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: StaticColors.backgroundColor
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:10,bottom:10),
                  width: constant.screenWidth,
                  height: constant.screenHeight * 0.4,
                    child: FutureBuilder(
                    future:CartController.getCart(context),
                    builder:(context,snapshot){
                      List<CartProduct> carts = [];
                      if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                        carts = snapshot.data as List<CartProduct>;
                      }
                      return snapshot.connectionState == ConnectionState.done 
                      ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: carts.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 10,
                          );
                        },
                        itemBuilder: (context,index){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              carts[index].tests.render(context, constant),
                              Text(
                                "Quantity : ${carts[index].quantity}"
                              ),
                            ],
                          );
                        
                        },
                      ) 
                      : Column();
                    }
                  ),
                ),
                
                Container(
                  width: constant.screenWidth,
                  height: constant.screenHeight * 0.05,
                  color: StaticColors.primary,
                  child: Center(
                    child: Text(
                      'Labs',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: StaticColors.backgroundColor
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:10,bottom:10),
                  width: constant.screenWidth,
                  height: constant.screenHeight * 0.4,
                    child: FutureBuilder(
                    future:CartController.getLab(context),
                    builder:(context,snapshot){
                      if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                        labs = snapshot.data as List<TestLab>;
                      }
                      return snapshot.connectionState == ConnectionState.done 
                      ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: labs.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 10,
                          );
                        },
                        itemBuilder: (context,index){
                          return ValueListenableBuilder(
                            valueListenable: labNotifier,
                            builder: (context, value, child){
                              return InkWell(
                                onTap: (){
                                  labNotifier.value = index;
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    labs[index].render(context, constant,labNotifier.value == index),
                                    // Text(
                                    //   "Quantity : ${carts[index].quantity}"
                                    // ),
                                  ],
                                ),
                              );
                            },
                          );
                        
                        },
                      ) 
                      : Column();
                    }
                  ),
                ),
                
                InkWell(
                  onTap: (){
                    checkout(context);
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: constant.screenWidth,
                    height: constant.screenHeight * 0.05,
                    decoration: BoxDecoration(
                      color: StaticColors.success,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: StaticColors.muted,
                          blurRadius: 4,
                          offset: Offset(0,3)
                        ),
                      ]
                    ),
                    child: Center(
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: StaticColors.backgroundColor
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
