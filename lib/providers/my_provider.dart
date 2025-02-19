

import 'package:cloud_firestore/cloud_firestore.dart' show CollectionReference, FirebaseFirestore;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

class MyProvider extends ChangeNotifier {
  String get currentLanguage => _currentLanguage;
  ThemeMode _themeMode = ThemeMode.light;
  var selectedDate = DateTime.now();
  var selectedTimer = TimeOfDay.now();
  String _currentLanguage = 'en';
  bool _isLogIn = false;
  int i = 0;
  bool get isLogIn => _isLogIn;
  String? userId;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  MyProvider() {
    checkAuth();
    getIdUser();
  }

  getIdUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    userId = sharedPreferences.getString("user");
    notifyListeners();
  }

  Future<void> checkAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLogIn = prefs.containsKey("user");
    print(_isLogIn);
    notifyListeners();
  }

  void changeThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    if (themeMode == ThemeMode.light) {
      prefs.setString("Theme_mode", "light");
    } else {
      prefs.setString("Theme_mode", "dark");
    }
    notifyListeners();
  }

  void changeThemeModeToLight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeMode = ThemeMode.light;

    prefs.setString("Theme_mode", "light");

    notifyListeners();
  }

  void changeThemeModeToDark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeMode = ThemeMode.dark;

    prefs.setString("Theme_mode", "dark");

    notifyListeners();
  }

  changeTimer(TimeOfDay timer) {
    selectedTimer = timer;
    notifyListeners();
  }

  changeDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void changeLanguage(BuildContext context, String language) {
    _currentLanguage = language;
    context.setLocale(Locale(language));
    notifyListeners();
  }


   ThemeMode themeMode = ThemeMode.light;
  void changeTheme() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
  


}
