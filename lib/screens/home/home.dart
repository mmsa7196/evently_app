import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_sun/providers/user_provider.dart';
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
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.map,
                ),
                label: "Map"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Love"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [
    HomeTab(),
    MapTab(),
    const LoveTab(),
    const ProfileTab(),
  ];
}
