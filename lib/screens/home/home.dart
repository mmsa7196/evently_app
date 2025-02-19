import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_c13_sun/screens/create_event/create_event.dart';
import 'package:todo_c13_sun/screens/home/tabs/home_tab.dart';
import 'package:todo_c13_sun/screens/home/tabs/love_tab.dart';
import 'package:todo_c13_sun/screens/home/tabs/map_tab.dart';
import 'package:todo_c13_sun/screens/home/tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "homeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Theme.of(context).floatingActionButtonTheme.foregroundColor,
        backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        onPressed: () {
          Navigator.pushNamed(context, CreateEventScreen.routeName);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },
          items:  [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home".tr()),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.map,
                ),
                label: "Map".tr()),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Love".tr()),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile".tr()),
          ]),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [
    const HomeTab(),
    const MapTab(),
    const LoveTab(),
    const ProfileTab(),
  ];
}
