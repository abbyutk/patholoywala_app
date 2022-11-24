import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pharmacy/config/app_config.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/model/package.dart';
import 'package:pharmacy/ress/style/static_colors.dart';

import '../../controllers/cart_controller.dart';
import '../../helpers/console.dart';
import '../style/static_style.dart';
import '../utils/static_data.dart';
import 'app_widget/custom_text.dart';

class PackageDetails extends StatefulWidget {
  const PackageDetails({ Key? key }) : super(key: key);

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

  final TextEditingController addressController = TextEditingController(text:kDebugMode ? "Black valley":"");
  final TextEditingController landmarkController = TextEditingController(text:kDebugMode ? "The wall":"");
  final TextEditingController dateController = TextEditingController(text:kDebugMode ? "2022/12/12":"");
  final TextEditingController timeController = TextEditingController(text:kDebugMode ? "12:20:10":"");
  final TextEditingController pincodeController = TextEditingController(text:kDebugMode ? "123456":"");
  final ValueNotifier<int> paymentNotifier = ValueNotifier(1);
  final ValueNotifier<int> labNotifier = ValueNotifier(0);

class _PackageDetailsState extends State<PackageDetails> {
  @override
  Widget build(BuildContext context) {
    Constants constants = Constants(context);
    Package package = constants.passedData['package'];
    void checkout(context){
    Map<String,String> args = {
            'collection_address':addressController.text,
            'collection_landmark':landmarkController.text,
            'collection_pincode':pincodeController.text,
            'collection_date':dateController.text,
            'collection_time': timeController.text,   
            'payment_method' : paymentNotifier.value.toString(),
            'odt':"1",
            'lab':package.labs[labNotifier.value].id.toString(),
            "package":package.id.toString()
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: StaticColors.primary,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: constants.screenHeight,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      width: constants.screenWidth * 0.9 ,
                      height: constants.screenHeight * 0.1,
                      decoration: BoxDecoration(
                        color: Color(0xffeeb9b9).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        children: [
                          CustomText(
                            text: package.title,
                            textStyle: StaticStyle.textStyle(
                              fontSide: 0.02,
                              fontWeight: FontWeight.bold,
                              height:constants.screenHeight,
                            ),
                          ),
                          // const Spacer(),
                          CustomText(
                            text: "${package.tests}+ tests includes",
                            textStyle: StaticStyle.textStyle(
                              fontSide: 0.025,
                              fontColor: Color(0xffc85353),
                              fontWeight: FontWeight.bold,
                              height:constants.screenHeight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Container(
                    width: constants.screenWidth * 0.8,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFf06868).withOpacity(0.8),
                        width: 1
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: CustomText(
                      text: package.description,
                      textStyle: StaticStyle.textStyle(
                        fontSide: 0.015,
                        textOverflow: TextOverflow.clip,
                        fontWeight: FontWeight.normal,
                        height:constants.screenHeight,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: constants.screenWidth,
                  height: constants.screenHeight * 0.05,
                  color: StaticColors.primary,
                  child: Center(
                    child: Text(
                      'Labs Offered',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: StaticColors.backgroundColor
                      ),
                    ),
                  ),
                ),
                DefaultTabController(
                  length: package.labs.length,
                  child: Column(
                    children: [
                      TabBar(
                        tabs: List.generate(package.labs.length, (index){
                          return Text(
                            package.labs[index].name,
                            style: TextStyle(
                              color: Colors.black
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        width: constants.screenWidth,
                        height: constants.screenHeight * 0.7,
                        child: TabBarView(
                          children: List.generate(package.labs.length, (index){
                            return Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(10),
                                  width: constants.screenWidth * 0.9,
                                  height: constants.screenWidth * 0.5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      "${AppConfig.mainUrl}/${package.labs[index].image}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: CustomText(
                                    text: package.description,
                                    textStyle: StaticStyle.textStyle(
                                      fontSide: 0.015,
                                      textOverflow: TextOverflow.clip,
                                      fontWeight: FontWeight.normal,
                                      height:constants.screenHeight,
                                    ),
                                  ),
                                ),
                                Row(
                                  children:[ Container(
                                    margin: EdgeInsets.all(10),
                                    width:constants.screenWidth * 0.5,
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: CustomText(
                                              text: "${StaticString.rupeeSymbol}${package.labs[index].price}",
                                              textStyle: StaticStyle.textStyle(
                                                fontSide: 0.025,
                                                fontWeight: FontWeight.bold,
                                                fontColor: StaticColors.muted,
                                                textDecoration: TextDecoration.lineThrough,
                                                height:constants.screenHeight,
                                              ),
                                            ),
                                          ),
                                          WidgetSpan(
                                            child: CustomText(
                                              text: "  ${StaticString.rupeeSymbol}${package.labs[index].sale}",
                                              textStyle: StaticStyle.textStyle(
                                                fontSide: 0.03,
                                                fontWeight: FontWeight.bold,
                                                fontColor: StaticColors.primary,
                                                height:constants.screenHeight,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                   InkWell(
                                  onTap: (){
                                    labNotifier.value = index;
                                    var dialog = context;
                                    showDialog(context: context, builder: (context){
                                      // dialog = context;
                                      return AlertDialog(
                                        title: Text('Book package'),
                                        content: SingleChildScrollView(
                                          child: Container(
                                            height: constants.screenHeight ,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                 Container(
                                                    width: constants.screenWidth,
                                                    height: constants.screenHeight * 0.05,
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
                                                    width: constants.screenWidth,
                                                    height: constants.screenHeight * 0.1,
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
                                                    width: constants.screenWidth,
                                                    height: constants.screenHeight * 0.1,
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
                                                    width: constants.screenWidth,
                                                    height: constants.screenHeight * 0.1,
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
                                                      width: constants.screenWidth,
                                                      height: constants.screenHeight * 0.1,
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
                                                      width: constants.screenWidth,
                                                      height: constants.screenHeight * 0.1,
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
                                                  InkWell(
                                                    onTap: (){
                                                      checkout(dialog);
                                                      Navigator.pop(context);
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
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    width: constants.screenWidth * 0.3,
                                    height: constants.screenHeight * 0.05,
                                    decoration: BoxDecoration(
                                      color: StaticColors.primary,
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
                                        'Book',
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
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
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