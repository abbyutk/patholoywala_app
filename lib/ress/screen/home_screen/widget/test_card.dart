// import 'package:flutter/material.dart';
// import 'package:pharmacy/ress/style/static_colors.dart';
// import 'package:pharmacy/ress/style/static_style.dart';
// import 'package:pharmacy/ress/services/route_controller.dart';

// import '../../app_widget/custom_text.dart';

// class TestCard extends StatelessWidget {
//   const TestCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final mediaQueryData = MediaQuery.of(context);
    // return Container(
    //   height: mediaQueryData.size.height * 0.35,
    //   width: mediaQueryData.size.height * 0.3,
    //   padding: const EdgeInsets.all(10),
    //   color: Colors.grey[100],
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       CustomText(
    //         text: "Ayushman Package",
    //         textStyle: StaticStyle.textStyle(
    //           fontSide: 0.025,
    //           fontWeight: FontWeight.bold,
    //           height: mediaQueryData.size.height,
    //         ),
    //       ),
    //       const Spacer(),
    //       CustomText(
    //         text: "Includes :  77 Parameters",
    //         textStyle: StaticStyle.textStyle(
    //           fontSide: 0.02,
    //           height: mediaQueryData.size.height,
    //         ),
    //       ),
    //       const Spacer(),
    //       SizedBox(
    //         width: mediaQueryData.size.width,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             CustomText(
    //               text: "• Blood Glucose Fasting",
    //               textStyle: StaticStyle.textStyle(
    //                 fontSide: 0.02,
    //                 height: mediaQueryData.size.height,
    //               ),
    //             ),
    //             CustomText(
    //               text: "• Complete Hemogram",
    //               textStyle: StaticStyle.textStyle(
    //                 fontSide: 0.02,
    //                 height: mediaQueryData.size.height,
    //               ),
    //             ),
    //             CustomText(
    //               text: "• Kidney Function Test (KFT)",
    //               textStyle: StaticStyle.textStyle(
    //                 fontSide: 0.02,
    //                 height: mediaQueryData.size.height,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       const Spacer(),
    //       OutlinedButton(
    //         onPressed: () => AppRouteController.gotoTestDetailScreen(context),
    //         child: CustomText(
    //           text: "+ Know More",
    //           textStyle: StaticStyle.textStyle(
    //             fontSide: 0.02,
    //             fontColor: StaticColors.primary,
    //             height: mediaQueryData.size.height,
    //           ),
    //         ),
    //         style: OutlinedButton.styleFrom(
    //           primary: StaticColors.primary,
    //           side: const BorderSide(
    //             color: StaticColors.primary,
    //           ),
    //           shape: const RoundedRectangleBorder(
    //             borderRadius: BorderRadius.all(
    //               Radius.circular(
    //                 20,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       const Spacer(),
    //       RichText(
    //         text: TextSpan(
    //           children: [
    //             WidgetSpan(
    //               child: CustomText(
    //                 text: "₹2796",
    //                 textStyle: StaticStyle.textStyle(
    //                   fontSide: 0.025,
    //                   fontWeight: FontWeight.bold,
    //                   fontColor: StaticColors.muted,
    //                   textDecoration: TextDecoration.lineThrough,
    //                   height: mediaQueryData.size.height,
    //                 ),
    //               ),
    //             ),
    //             WidgetSpan(
    //               child: CustomText(
    //                 text: "  ₹699",
    //                 textStyle: StaticStyle.textStyle(
    //                   fontSide: 0.03,
    //                   fontWeight: FontWeight.bold,
    //                   fontColor: StaticColors.primary,
    //                   height: mediaQueryData.size.height,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
//   }
// }
