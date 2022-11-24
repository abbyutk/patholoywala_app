import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:shimmer/shimmer.dart';

class FuturePlaceHolder{
  static dummyService(BuildContext context, Constants constant){
    return Column(
      children: List.generate(5, (index) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              width: constant.screenWidth * 0.4,
              height: constant.screenWidth * 0.4,
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child:Shimmer.fromColors(
                  baseColor: Colors.grey[300]??Colors.grey,
                  highlightColor: Colors.grey[100]??Colors.grey,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: constant.screenWidth * 0.4,
              height: constant.screenWidth * 0.06,
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child:Shimmer.fromColors(
                  baseColor: Colors.grey[300]??Colors.grey,
                  highlightColor: Colors.grey[100]??Colors.grey,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
              ),
            ),
          ],
        )
      )
    );
  }

  static dummyBooking(BuildContext context, Constants constant){
    return  Column(
      children: List.generate(5, (index) => Container(
      margin: EdgeInsets.all(10),
      width: constant.screenWidth,
      height: constant.screenWidth * 0.4,
      child:Shimmer.fromColors(
                baseColor: Colors.grey[300]??Colors.grey,
                highlightColor: Colors.grey[100]??Colors.grey,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
            ),
    )),
    );
  }
  static dummyPaymentCard(BuildContext context, Constants constant){
    return Column(
      children: List.generate(5, (index) => Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: constant.screenWidth * 0.1,
              height: constant.screenWidth * 0.1,
              decoration: BoxDecoration(
                color:Colors.grey,
                shape: BoxShape.circle
              ),
            ),
            Container(
              margin:EdgeInsets.all(10),
              width: constant.screenWidth * 0.6,
              height: constant.screenWidth * 0.1,
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child:Shimmer.fromColors(
                  baseColor: Colors.grey[300]??Colors.grey,
                  highlightColor: Colors.grey[100]??Colors.grey,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
              ),
            ),
          ],
        )
      )
    );
  }
}