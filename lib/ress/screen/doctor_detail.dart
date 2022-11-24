import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy/config/app_config.dart';
import 'package:pharmacy/controllers/appointment_controller.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/helpers/notify.dart';
import 'package:pharmacy/ress/model/api_response.dart';
import 'package:pharmacy/ress/model/doctor.dart';
import 'package:pharmacy/ress/screen/app_widget/loading.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy/ress/utils/static_data.dart';

class DoctorDetail extends StatefulWidget {
  const DoctorDetail({ Key? key }) : super(key: key);

  @override
  State<DoctorDetail> createState() => _DoctorDetailState();
}

final TextEditingController dateController = TextEditingController(text:kDebugMode ? "2022/12/12":"");
final TextEditingController timeController = TextEditingController(text:kDebugMode ? "12:20:10":"");

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

class _DoctorDetailState extends State<DoctorDetail> {
  @override
  Widget build(BuildContext context) {
    Constants constants = Constants(context);
    Doctor doctor = constants.passedData["doctor"];
    final dateFormat = DateFormat('dd-MMMM-yyyy');
    DateTime openTime = DateTime.parse("2012-12-12 ${doctor.open}.000");
    DateTime closeTime = DateTime.parse("2012-12-12 ${doctor.close}");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: StaticColors.primary,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                children: [
                  Container(
                    width: constants.screenWidth,
                    height: constants.screenHeight * 0.3,
                    child: Image.network(
                      "${AppConfig.mainUrl}/${doctor.image}",
                      color: Colors.black.withOpacity(0.5),
                      colorBlendMode: BlendMode.multiply,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.name,
                          style: GoogleFonts.poppins(
                            color:Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:constants.screenWidth * 0.05,
                          ),
                        ),
                        Text(
                          doctor.specialty,
                          style: GoogleFonts.poppins(
                            color:Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize:constants.screenWidth * 0.04,
                          ),
                        ),
                        Text(
                          "charge: ${StaticString.rupeeSymbol} ${doctor.price}/-",
                          style: GoogleFonts.poppins(
                            color:Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:constants.screenWidth * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top:10,left:10),
                alignment: Alignment.bottomLeft,
                child: Text(
                    'Description : ',
                    style: GoogleFonts.poppins(
                      color:Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize:constants.screenWidth * 0.04,
                    ),
                  ),
              ),
              Positioned(
                child: Text(
                  doctor.description,
                  style: GoogleFonts.poppins(
                    color:Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize:constants.screenWidth * 0.04,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Open time \n ${openTime.hour.toString().length > 1 ? '':0}${openTime.hour} : ${openTime.minute.toString().length > 1 ? '':0}${openTime.minute}",
                      style: GoogleFonts.poppins(
                        color:Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize:constants.screenWidth * 0.04,
                      ),
                    ),
                    Text(
                      "Close time \n ${closeTime.hour.toString().length > 1 ? '':0}${closeTime.hour} : ${closeTime.minute.toString().length > 1 ? '':0}${closeTime.minute}",
                      style: GoogleFonts.poppins(
                        color:Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize:constants.screenWidth * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
               Container(
                  width: constants.screenWidth,
                  height: constants.screenHeight * 0.05,
                  margin: EdgeInsets.only(top: 10),
                  color: StaticColors.primary,
                  child: Center(
                    child: Text(
                      'Book Appointment',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: StaticColors.backgroundColor
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                  onTap: ()=>pickTime(context,false),
                  child: Container(
                    width: constants.screenWidth * 0.4,
                    height: constants.screenHeight * 0.1,
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: dateController,
                      enabled: false,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        label: Text("Select date"),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: ()=>pickTime(context,true),
                  child: Container(
                    width: constants.screenWidth * 0.4,
                    height: constants.screenHeight * 0.1,
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: timeController,
                      enabled: false,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        label: Text("Select time"),
                      ),
                    ),
                  ),
                ),
                  ],
                ),
                InkWell(
                  onTap: ()async{
                    // var dialog = context;
                    // showDialog(context: context, builder: (context){
                    //   dialog = context;
                    //   return AlertDialog(
                    //     content: Loading(onlyLoad: true,),
                    //   );
                    // });
                    AppointmentController.bookAppointment(context, {
                      "doctor":doctor.id.toString(),
                      "appointment_time":dateController.text,
                      "appointment_date":timeController.text,
                    });
                    // ApiResponse response = await AppointmentController.bookAppointment(context, {
                    //   "doctor":doctor.id.toString(),
                    //   "appointment_time":dateController.text,
                    //   "appointment_date":timeController.text,
                    // });
                    // Notify(
                    //   context: context,
                    //   message: response.message,
                    //   type: response.success ? 'success' : 'error',
                    //   messageType: Notify.APINOTIFICATION
                    // );
                    // Navigator.pop(dialog);
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: constants.screenWidth,
                    height: constants.screenHeight * 0.05,
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
    );
  }
}