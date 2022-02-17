import 'package:flutter/material.dart';
import 'package:pharmacy/ress/style/static_style.dart';
import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/utils/static_assets_path.dart';

import '../../app_widget/custom_text.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return SizedBox(
      height: mediaQueryData.size.height * 0.25,
      width: mediaQueryData.size.height * 0.2,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                  height: (constraints.maxHeight * 0.7) - 8,
                  width: constraints.maxWidth,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: constraints.maxHeight * 0.7,
                          width: constraints.maxWidth,
                          child: Image.asset(
                            StaticImagePath.rootPath + "doctor.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: constraints.maxHeight * 0.15,
                          width: constraints.maxWidth * 0.7,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: StaticColors.secondaryPrimary,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: CustomText(
                            text: "Features",
                            textStyle: StaticStyle.textStyle(
                              fontSide: 0.022,
                              fontColor: StaticColors.text,
                              height: mediaQueryData.size.height,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr. Jane",
                      textScaleFactor: 1,
                      style: StaticStyle.textStyle(
                        fontSide: 0.02,
                        fontWeight: FontWeight.bold,
                        height: mediaQueryData.size.height,
                      ),
                    ),
                    Text(
                      "Dermatologist",
                      textScaleFactor: 1,
                      style: StaticStyle.textStyle(
                        fontSide: 0.015,
                        height: mediaQueryData.size.height,
                      ),
                    ),
                    const Spacer(),
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.star,
                              color: StaticColors.primary,
                              size: StaticStyle.getAdaptiveSized(
                                mediaQueryData.size.height,
                                0.022,
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: Text(
                              "4.8(512 patients)",
                              textScaleFactor: 1,
                              style: StaticStyle.textStyle(
                                fontSide: 0.015,
                                fontColor: StaticColors.muted,
                                height: mediaQueryData.size.height,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
