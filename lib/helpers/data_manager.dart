
import 'package:flutter/foundation.dart';
import 'package:pharmacy/ress/model/user.dart';

class DataManager{
  bool willChange;
  dynamic value;

  DataManager({required this.willChange, required this.value});

  static const String USER_DATA = 'user_data';

  static const EMAIL = 'hnsyd@mailto.plus';

  // static Map<String, RedisConnection> connections = {};
  
  static ValueNotifier<int> notificationNotifier = ValueNotifier<int>(0);

  static User user = User.dummyProfile();

  static String token = '';

  static String resolveFrequency(int i){
    String f = "Never";
    switch(i){
      case 0:f="Never";
      break;
      case 1:f="Daily";
      break;
      case 2:f="Customize";
      break;
      default:f="Never";
    }
    return f;
  }
  static int frequencyToString(String i){
    int f = 0;
    switch(i){
      case "Never":f=0;
      break;
      case "Daily":f=1;
      break;
      case "Customize":f=2;
      break;
      default:f=0;
    }
    return f;
  }

  static Map<String,double> location = {'latitude':0,"longitude":0,'altitude':0};

  static Map<String,String> cart = {
    "booking_service_id":"0",
    "booking_start_time":"11:11",
    "booking_end_time":"11:11",
    "booking_no_of_personel":"0",
    "booking_frequncy":"0",
    "booking_start_date":"12-12-12",
    "booking_end_date":"12-12-12",
    "dress_code_id":"0",
  };

  static resolveBookingStatus(int i){
    String f = "Pending";
    switch(i){
      case 0:f="Pending";
      break;
      case 1:f="Booked";
      break;
      case 2:f="Finished";
      break;
      case 3:f="Cancelled";
      break;
      default:f="Pending";
    }
    return f;
  }

  // static FlutterBackgroundService? service;

  // static initializeLocationService()async{
  //   DataManager.service = FlutterBackgroundService();
  // await service?.configure(
  //   androidConfiguration: AndroidConfiguration(
  //     // this will executed when app is in foreground or background in separated isolate
  //     onStart: (){
  //       service?.setForegroundMode(false);
  //     },

  //     // auto start service
  //     autoStart: true,
  //     isForegroundMode: false,
  //   ),
  //   iosConfiguration: IosConfiguration(
  //     // auto start service
  //     autoStart: true,

  //     // this will executed when app is in foreground in separated isolate
  //     onForeground: (){
  //       Console.log('Running in foreground.');
  //     },

  //     // you have to enable background fetch capability on xcode project
  //     onBackground: (){

  //       Timer.periodic(const Duration(seconds: 10), (timer) {
  //         Console.log('updating location');
  //         NearByController.updateLocation(DataManager.user, Location());
  //        });
  //     },
  //   ),
  // );
  // }

  static DataManager _instance({willChange=false, required value}) =>DataManager(value: value, willChange: willChange);

  // static 

  static saveUserData(User user){
    DataManager temp = DataManager._instance(value: user);
    DataManager? data = globalDataNotifier[USER_DATA];
    if(data != null){
      data.value = user;
    }else{
      DataManager.save(temp, USER_DATA);
    }
    
  }

  static save(DataManager data, String name){
    globalDataNotifier[name] = data;
  }

  static Map<String,DataManager> globalDataNotifier = {};
}