import 'package:flutter/material.dart';
import 'package:pharmacy/controllers/appointment_controller.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/model/appointment.dart';
import 'package:pharmacy/ress/style/static_colors.dart';

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({Key? key}) : super(key: key);


  List<Appointment> appointments = [];
  ValueNotifier<bool> appointmentNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    Constants constant = Constants(context);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: ()async{
          appointments = await AppointmentController.getAppointment(context);
          appointmentNotifier.value = !appointmentNotifier.value;
        },
        child: Container(
          // color: StaticColors.muted.withOpacity(0.4),
          margin: EdgeInsets.only(bottom: constant.screenHeight * 0.12),
          child: SingleChildScrollView(
            child: FutureBuilder(
              future:AppointmentController.getAppointment(context),
              builder:(context,snapshot){
                if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                  appointments = snapshot.data as List<Appointment>;
                }
                return ValueListenableBuilder(valueListenable: appointmentNotifier, builder: (context,value,child){
                  return snapshot.connectionState == ConnectionState.done 
                ? Column(
                  children: List.generate(appointments.length, (index) => appointments[index].render(context, constant)),
                )  
                : Column();
                });
              }
            ),
          ),
        ),
      ),
    );
  }
}
