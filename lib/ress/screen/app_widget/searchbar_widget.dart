import 'package:flutter/material.dart';

import 'package:pharmacy/ress/style/static_colors.dart';
import 'package:pharmacy/ress/style/static_style.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: SizedBox(
        height: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.075,
        width: mediaQueryData.size.width * 0.85,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: StaticColors.muted,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Search",
                textScaleFactor: 1,
                style: StaticStyle.textStyle(
                  fontSide: 0.03,
                  fontColor: StaticColors.muted,
                  height: mediaQueryData.size.height,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
