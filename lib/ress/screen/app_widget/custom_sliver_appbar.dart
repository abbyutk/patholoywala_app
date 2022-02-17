import 'package:flutter/material.dart';

class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Widget? titel;
  final Widget appbarleadingWidget;
  final List<Widget>? appbaraction;
  final List<Widget> widgetInExpendedView;
  final Color backgroundColor;
  final double elevation;
  final bool appbarinExpendedView;
  const CustomSliverAppBar({
    this.titel,
    this.appbarinExpendedView = true,
    required this.appbarleadingWidget,
    required this.backgroundColor,
    required this.widgetInExpendedView,
    required this.expandedHeight,
    this.appbaraction,
    this.elevation = 0,
  });

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  PreferredSizeWidget appBar({
    required BuildContext context,
    required bool isVisible,
    required MediaQueryData mediaQueryData,
  }) {
    return AppBar(
      leading: appbarleadingWidget,
      title: isVisible ? titel : null,
      elevation: isVisible ? elevation : 0,
      actions: isVisible ? appbaraction : null,
      backgroundColor: isVisible ? backgroundColor : Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final mediaQueryData = MediaQuery.of(context);
    // print("ShrinkOffset : $shrinkOffset");
    // print("Expendes : $expandedHeight");
    // print(kToolbarHeight);
    // print("hidefector ${shrinkOffset / expandedHeight}");
    return Stack(
      fit: StackFit.expand,
      children: [
        if ((shrinkOffset / expandedHeight) < 0.35)
          Opacity(
            opacity: disappear(shrinkOffset),
            child: Stack(
              children: [
                ...widgetInExpendedView,
                if (appbarinExpendedView)
                  appBar(
                    isVisible: false,
                    mediaQueryData: mediaQueryData,
                    context: context,
                  ),
              ],
            ),
          ),
        Opacity(
          opacity: appear(shrinkOffset),
          child: appBar(
            mediaQueryData: mediaQueryData,
            context: context,
            isVisible: !((shrinkOffset / expandedHeight) < 0.35),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
