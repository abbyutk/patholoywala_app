import 'package:flutter/material.dart';
import 'package:pharmacy/ress/utils/static_data.dart';

import './time_card_widget.dart';

class TimeListWidget extends StatelessWidget {
  const TimeListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final listofTime = StaticString.time as List<Map<String, Object>>;
    return Container(
      height: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.06,
      width: mediaQueryData.size.width,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: ListView.separated(
        itemCount: listofTime.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return TimeCardWidget(
            isCheked: index == 1,
            timeData: listofTime[index],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 15,
          );
        },
      ),
    );
  }
}
