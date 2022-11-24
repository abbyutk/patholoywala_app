import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/utils/static_data.dart';

import '../../helpers/notify.dart';

class Appointment{


  final String id, doctorId, doctorName, price, doctorSpecialty, time, payment, link;

  Appointment({required this.id, required this.doctorId, required this.doctorName, required this.price, required this.doctorSpecialty, required this.time, required this.payment, required this.link});

  static Appointment fromJson(json){
    
    return Appointment(
      id:"${json["appointment_id"]??0}", 
      doctorId:"${json["appointment_doctor_id"]??0}", 
      doctorName:json["appointment_doctor_name"]??"", 
      price:json["appointment_price"]??"0.00", 
      doctorSpecialty:json["appointment_doctor_specialty"]??"", 
      time:json["appointment_time"]??"", 
      payment:"${json["appointment_payment_status"]??0}", 
      link:json["meeting_link"]??""
    );

  }

  Widget render(BuildContext context, Constants constant){
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(left: 10, right:10,bottom: 10),
        width: constant.screenWidth,
        height: constant.screenHeight * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: StaticColors.primary
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topRight,
              padding:EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: resolveColor(int.parse(this.payment)),
                boxShadow: [
                  BoxShadow(
                    color: StaticColors.muted.withOpacity(0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Text(
                "${resolveStatus(int.parse(this.payment))}",
                style: StaticStyle.appointment,
                textAlign: TextAlign.end,
              ),
            ),
            Text(
              "${this.doctorName}(${this.doctorSpecialty})",
              style: StaticStyle.appointment,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  this.time.split(" ")[0],
                  style: StaticStyle.appointment.copyWith(fontSize: 15),
                ),
                Text(
                  this.time.split(" ")[1],
                  style: StaticStyle.appointment.copyWith(fontSize: 15),
                ),
              ],
            ),
            Text(
              "${StaticString.rupeeSymbol}${this.price}",
              style: StaticStyle.appointment,
            ),
            Visibility(
              visible: link != '',
              child: Row(
                children: [
                  Container(
                    width: constant.screenWidth * 0.6,
                    height: constant.screenHeight * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                      child: Text(
                        link
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      Clipboard.setData(ClipboardData(text: link));
                      Notify(
                      context: context,
                      message: "Meeting link is copied on your clipboard.",
                      messageType: Notify.TEXTNOTIFICATION,
                      type: 'info');
                     //  AppointmentController.saveLink(context, "${appointment?.id??0}", linkController.text);
                    },
                    icon: Icon(
                      Icons.copy,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }

  static String resolveStatus(int status){
    var stat = "Failed";
    switch(status){
      case 0: stat = "Pending";
      break;
      case 1: stat = "Placed";
      break;
      case 2: stat = "Accepted";
      break;
      case 3: stat = "Completed";
      break;
      case 4: stat = "Cancelled By User";
      break;
      case 5: stat = "Cancelled";
      break;
      default: stat = "Failed" ; 
    }
  return stat;
  }
  static Color resolveColor(int color){
    var col = StaticColors.error;
    switch(color){
      case 0: col = StaticColors.warn;
      break;
      case 1: col = StaticColors.warn;
      break;
      case 2: col = StaticColors.info;
      break;
      case 3: col = StaticColors.success;
      break;
      case 4: col = StaticColors.error;
      break;
      case 5: col = StaticColors.error;
      break;
      default: col = StaticColors.error; 
    }
  return col;
  }

}