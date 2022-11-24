import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';
import '../appointment_screen/appointmen_screen.dart';
import '../favourite_screen/favourite_screen.dart';
import '../profile_screen/profile_screen.dart';

import '../app_widget/custom_appdrawer.dart';
import './widget/bottombar_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int screenIndex = 0;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final screenList =  [
    HomeScreen(),
    AppointmentScreen(),
    FavouriteScreen(),
    Profile(),
  ];

  void setIndex(tabIndex) {
    setState(() {
      screenIndex = tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      drawer: const CustomAppDrawer(),
      body: IndexedStack(
        index: screenIndex,
        children: screenList,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        child: BottomBarWidget(
          index: screenIndex,
          activeColor: Theme.of(context).primaryColor,
          inActiveColor: Colors.grey,
          getIndex: (index) => setIndex(index),
          tabList: [
            BottomBarItemData(
              icon: Icons.home,
              lable: "Home",
            ),
            BottomBarItemData(
              icon: Icons.assignment,
              lable: "Appointments",
            ),
            BottomBarItemData(
              icon: Icons.book_rounded,
              lable: "Bookings",
            ),
            BottomBarItemData(
              icon: Icons.account_circle_outlined,
              lable: "Profile",
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
