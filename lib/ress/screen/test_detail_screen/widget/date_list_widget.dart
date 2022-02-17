import 'package:flutter/material.dart';
import 'package:pharmacy/ress/style/static_style.dart';

import 'date_card_widget.dart';

class DateListWidget extends StatelessWidget {
  const DateListWidget({Key? key}) : super(key: key);

  List<DateTime> getDays() {
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime(startDate.year, startDate.month + 1, 0);
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final List<DateTime> listOfDays = getDays();
    return Container(
      height: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.09,
      width: mediaQueryData.size.width,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Row(
        children: [
          SizedBox(
            height: double.infinity,
            width: mediaQueryData.size.width * 0.85,
            child: ListView.separated(
              itemCount: listOfDays.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return DateCardWidget(
                  dateData: listOfDays[index],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 15,
                );
              },
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios,
                size: StaticStyle.getAdaptiveSized(
                  mediaQueryData.size.height,
                  0.05,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
