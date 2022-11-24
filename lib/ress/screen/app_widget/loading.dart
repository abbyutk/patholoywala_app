import 'package:flutter/widgets.dart';
import 'package:pharmacy/controllers/asset_controller.dart';
import 'package:pharmacy/helpers/constants.dart';
import 'package:pharmacy/ress/services/route_controller.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
class Loading extends StatelessWidget {
  final bool onlyLoad;
  const Loading({ Key? key, this.onlyLoad = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    void whenClose(context){
      Constants constant = Constants(context);
    var args = constant.passedData;
      Future<dynamic> a = args['whenclose'];
      Function b = args['actionFunction'];
      a.then((value){
        AppRouteController.goBack(context);
        b(value);
      });
    }
    if(!onlyLoad)whenClose(context);
    return Container(
      color: StaticColors.loaderBackground,
      child: Center(
        child: AssetController.loading,
      ),
    );
  }
}