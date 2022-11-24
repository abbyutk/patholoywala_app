import 'package:flutter/material.dart';
import 'package:pharmacy/controllers/doctor_controller.dart';
import 'package:pharmacy/controllers/test_controller.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/model/test_category_model.dart';

class TestCategoryScreen extends StatelessWidget {
  const TestCategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Constants constant = Constants(context);
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
                  'Test By Categories',
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
              future: TestController.getCategories(context),
              builder: (context, snapshot){
                List<TestCategory> categories = []; 
                if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                  categories = snapshot.data as List<TestCategory> ;
                }
                return snapshot.connectionState == ConnectionState.done 
                ? GridView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context,index){
                    return categories[index].render(context, constant);
                  },
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
