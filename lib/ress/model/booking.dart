import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/utils/static_data.dart';

class Booking{


  final String id, address, landmark, pincode, date, time, tests, status,report, total;

  Booking({required this.id, required this.total, required this.address, required this.landmark, required this.pincode, required this.date, required this.time, required this.tests, required this.status,required this.report});

  static Booking fromJson(json){
    
    return Booking(
      id:"${json["order_id"]??0}", 
      address:"${json["collection_address"]??0}", 
      landmark:json["collection_landmark"]??"", 
      pincode:json["collection_pincode"]??"0.00", 
      date:json["collection_date"]??"", 
      time:json["collection_time"]??"", 
      tests:"${json["items_in_bag"]??0}", 
      status:"${json["order_status"]??0}",
      report:json["report"]??"",
      total:json["items_subtotal"]??"0"
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
                color: resolveColor(int.parse(this.status)),
                boxShadow: [
                  BoxShadow(
                    color: StaticColors.muted.withOpacity(0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "#Order id: #$id",
                    style: StaticStyle.appointment,
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    "${resolveStatus(int.parse(status))}",
                    style: StaticStyle.appointment,
                    textAlign: TextAlign.end,
                  )
                ],
              ),
            ),
            Text(
              "$address",
              style: StaticStyle.appointment,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: StaticStyle.appointment.copyWith(fontSize: 15),
                ),
                Text(
                  time,
                  style: StaticStyle.appointment.copyWith(fontSize: 15),
                ),
              ],
            ),
            Text(
              "${StaticString.rupeeSymbol}$total",
              style: StaticStyle.appointment,
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
      case 3: stat = "Collected";
      break;
      case 4: stat = "Out for Pathology";
      break;
      case 5: stat = "Sample submitted";
      break;
      case 6: stat = "Cancelled";
      break;
      case 7: stat = "Cancelled By Admin";
      break;
      case 8: stat = "Report Uploaded";
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
      case 3: col = StaticColors.info;
      break;
      case 4: col = StaticColors.info;
      break;
      case 5: col = StaticColors.info;
      break;
      case 6: col = StaticColors.error;
      break;
      case 7: col = StaticColors.error;
      break;
      case 8: col = StaticColors.success;
      break;
      default: col = StaticColors.error; 
    }
  return col;
  }

}