import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pharmacy/config/app_config.dart';
import 'package:pharmacy/controllers/cart_controller.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/helpers/notify.dart';
import 'package:pharmacy/ress/model/booking.dart';
import 'package:pharmacy/ress/model/cart_model.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/utils/static_data.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingDetails extends StatelessWidget {
  BookingDetails({Key? key}) : super(key: key);


void launchurl(String url, BuildContext context) async {
    if (true) {
      await launch(url);
      return;
    }
    Notify(
      context: context,
      message: "Unable to open url",
      messageType: Notify.TEXTNOTIFICATION,
      type: 'error'
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final Constants constant = Constants(context);
    final Booking booking = constant.passedData["booking"];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order id : #${booking.id}"),
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
                      'sample collection address,date & time',
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
                    initialValue: booking.address,
                    enabled: false,
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
                    initialValue: booking.landmark,
                    enabled: false,
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
                    initialValue: booking.pincode,
                    enabled: false,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      label: Text("Collection Pincode"),
                    ),
                  ),
                ),
                 Container(
                    width: constant.screenWidth,
                    height: constant.screenHeight * 0.1,
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      enabled: false,
                      initialValue: booking.date,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        label: Text("Collection date"),
                      ),
                    ),
                  ),
                
                Container(
                    width: constant.screenWidth,
                    height: constant.screenHeight * 0.1,
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      enabled: false,
                      initialValue: booking.time,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        label: Text("Collection time"),
                      ),
                    ),
                  ),
                // DropdownButtonFormField(
                //   value: book, 
                //       items: [
                //         DropdownMenuItem(child: Text("Online Payment"), value: 1,),
                //         DropdownMenuItem(child: Text("Cash on collection"), value: 0,)
                //       ],
                //     ),
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
                    future:CartController.getBookingItems(context,booking.id),
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
                // InkWell(
                //   onTap: (){
                //     // checkout(context);
                //   },
                //   child: Container(
                //     margin: EdgeInsets.all(10),
                //     width: constant.screenWidth,
                //     height: constant.screenHeight * 0.05,
                //     decoration: BoxDecoration(
                //       color: StaticColors.success,
                //       borderRadius: BorderRadius.circular(20),
                //       boxShadow: [
                //         BoxShadow(
                //           color: StaticColors.muted,
                //           blurRadius: 4,
                //           offset: Offset(0,3)
                //         ),
                //       ]
                //     ),
                //     child: Center(
                //       child: Text(
                //         'Cancel',
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           color: StaticColors.backgroundColor
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Visibility(
                  visible: booking.status == "8",
                  child: InkWell(
                    onTap: (){
                      launchurl("${AppConfig.mainUrl}/${booking.report}", context);
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
                          color: StaticColors.primary,
                          blurRadius: 4,
                          offset: Offset(0,3)
                        ),
                      ]
                    ),
                    child: Center(
                      child: Text(
                        'Download Report',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: StaticColors.backgroundColor
                        ),
                      ),
                    )),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    width: constant.screenWidth,
                    height: constant.screenHeight * 0.05,
                    decoration: BoxDecoration(
                      color: StaticColors.muted,
                      borderRadius: BorderRadius.circular(20),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: StaticColors.muted,
                      //     blurRadius: 4,
                      //     offset: Offset(0,3)
                      //   ),
                      // ]
                    ),
                    child: Center(
                      child: Text(
                        'Total : ${StaticString.rupeeSymbol}${booking.total}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: StaticColors.backgroundColor
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
