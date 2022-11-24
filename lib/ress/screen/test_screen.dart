import 'package:flutter/material.dart';
import 'package:pharmacy/controllers/doctor_controller.dart';
import 'package:pharmacy/controllers/test_controller.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/model/doctor.dart';
import 'package:pharmacy/ress/model/test.dart';
import 'package:pharmacy/ress/screen/app_widget/custom_sliver_appbar.dart';
import 'package:pharmacy/ress/screen/app_widget/test_category_card.dart';
import 'package:pharmacy/ress/screen/app_widget/widget_for_expended_view.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/model/test_category_model.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Constants constant = Constants(context);
    final int category = constant.passedData["category"];
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(constant.screenHeight * 0.2),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: StaticColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(),
                Text(
                  'All Tests',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: StaticColors.backgroundColor,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(    
          child: Padding(
            padding: EdgeInsets.all(20),
            child: FutureBuilder(
              future: category > 0 ? TestController.getTestsByCategory(context, category) :TestController.getTests(context),
              builder: (context, snapshot){
                List<Test> tests = []; 
                if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                  tests = snapshot.data as List<Test> ;
                }
                return snapshot.connectionState == ConnectionState.done 
                ? GridView.builder(
                  itemCount: tests.length,
                  itemBuilder: (context,index){
                    return tests[index].render(context, constant);
                  },
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,mainAxisSpacing: 10,childAspectRatio: 20/12),
                )
                : Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
