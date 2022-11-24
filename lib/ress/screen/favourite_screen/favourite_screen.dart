import 'package:flutter/material.dart';
import 'package:pharmacy/controllers/appointment_controller.dart';
import 'package:pharmacy/controllers/test_controller.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/model/appointment.dart';
import 'package:pharmacy/ress/model/booking.dart';
import 'package:pharmacy/ress/services/route_controller.dart';
import 'package:pharmacy/ress/style/static_colors.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({Key? key}) : super(key: key);


  List<Booking> bookings = [];
  ValueNotifier<bool> bookingNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    Constants constant = Constants(context);
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: ()async{
            bookings = await TestController.getBookings(context);
            bookingNotifier.value = !bookingNotifier.value;
          },
          child: Container(
            // color: StaticColors.muted.withOpacity(0.4),
            margin: EdgeInsets.only(bottom: constant.screenHeight * 0.12),
            child: SingleChildScrollView(
              child: FutureBuilder(
                future:TestController.getBookings(context),
                builder:(context,snapshot){
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                    bookings = snapshot.data as List<Booking>;
                  }
                  return ValueListenableBuilder(valueListenable: bookingNotifier, builder: (context,value,child){
                    return snapshot.connectionState == ConnectionState.done 
                  ? Column(
                    children: List.generate(bookings.length, (index) => InkWell(
                      onTap: ()=>AppRouteController.bookingDetailsScreen(context,bookings[index]),
                      child:  bookings[index].render(context, constant),
                    )),
                  )  
                  : Column();
                  });
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}
