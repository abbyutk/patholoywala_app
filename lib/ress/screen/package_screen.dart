import 'package:flutter/material.dart';
import 'package:pharmacy/controllers/doctor_controller.dart';
import 'package:pharmacy/controllers/package_controller.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/model/doctor.dart';
import 'package:pharmacy/ress/model/package.dart';
import 'package:pharmacy/ress/screen/app_widget/custom_sliver_appbar.dart';
import 'package:pharmacy/ress/screen/app_widget/test_category_card.dart';
import 'package:pharmacy/ress/screen/app_widget/widget_for_expended_view.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/model/test_category_model.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({
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
                  'All Packages',
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
              future: PackageController.getPackages(context),
              builder: (context, snapshot){
                List<Package> packages = []; 
                if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                  packages = snapshot.data as List<Package> ;
                }
                return snapshot.connectionState == ConnectionState.done 
                ? GridView.builder(
                  itemCount: packages.length,
                  itemBuilder: (context,index){
                    return packages[index].render(context, constant);
                  },
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 20/12,mainAxisSpacing: 10),
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
