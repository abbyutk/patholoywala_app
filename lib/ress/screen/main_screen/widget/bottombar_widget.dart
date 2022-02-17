import 'package:flutter/material.dart';

import 'bottombartab_widget.dart';

class BottomBarItemData {
  final IconData icon;
  final String lable;

  BottomBarItemData({
    required this.icon,
    required this.lable,
  });
}

class BottomBarWidget extends StatelessWidget {
  final Function getIndex;
  final List<BottomBarItemData> tabList;
  final int index;
  final Color activeColor;
  final Color inActiveColor;
  const BottomBarWidget({
    Key? key,
    required this.index,
    required this.getIndex,
    required this.tabList,
    required this.activeColor,
    required this.inActiveColor,
  }) : super(key: key);

  List<Widget> getBottomBarItem(final temptab, final tempindex) {
    List<Widget> bottomBarTab = [];
    for (int i = 0; i < (temptab.length); i++) {
      bottomBarTab.add(
        InkWell(
          onTap: () => changeIndex(i, tempindex),
          splashFactory: NoSplash.splashFactory,
          child: BottomBarTabWidget(
            color: i == tempindex ? activeColor : inActiveColor,
            icon: temptab[i].icon,
            titel: temptab[i].lable,
          ),
        ),
      );
    }
    return bottomBarTab;
  }

  void changeIndex(tabIndex, tempindex) {
    if (tabIndex != tempindex) {
      getIndex(tabIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Container(
      height: (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.1,
      width: mediaQueryData.size.width * 0.9,
      decoration: BoxDecoration(
        color: const Color(0xffEFEFEF),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(
              3.0,
              3.0,
            ),
            blurRadius: 15.0,
            spreadRadius: 5.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //B
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(
            (mediaQueryData.size.height - mediaQueryData.padding.top) * 0.05,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: getBottomBarItem(tabList, index),
      ),
    );
  }
}
