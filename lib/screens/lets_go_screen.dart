import 'package:animated_toggle_switch/animated_toggle_switch.dart' show AnimatedToggleSwitch, ToggleStyle;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_sun/onboarding_Screen.dart';
import 'package:todo_c13_sun/providers/my_provider.dart';

class IntroductionScreen extends StatefulWidget {
  static const String routeName = "IntroductionScreen";

  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 18.0, right: 18, left: 18),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, OnboardingScreen.routeName);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: Color(0xFF5669FF),
          ),
          child: Text(
            "lets_start".tr(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Image.asset("assets/images/app_logo.png"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              "assets/images/intro_img.png",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 28),
            Text(
              context.tr('introduction_title'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 28),
            Text(
              "introduction_description".tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "language".tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                AnimatedToggleSwitch<String>.rolling(
                  current: provider.currentLanguage,
                  values: const ["en", "ar"],
                  onChanged: (value) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      provider.changeLanguage(context, value);
                    });
                  },
                  iconList: [
                    Image.asset("assets/images/En.png"),
                    Image.asset("assets/images/AR.png"),
                  ],
                  height: 40,
                  indicatorSize: Size(40, 40),
                  style: ToggleStyle(
                    backgroundColor: Colors.transparent,
                    indicatorColor: Theme.of(context).primaryColor,
                    borderColor: Theme.of(context).primaryColor,
                  ),
                ),
              ], // en >> 0 , ar >> 1
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "theme".tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                AnimatedToggleSwitch<ThemeMode>.rolling(
                  current: provider.themeMode,
                  values: const [ThemeMode.light, ThemeMode.dark],
                  onChanged: (value) {
                    provider.changeTheme();
                  },
                  iconList: [
                    Image.asset("assets/images/Sun.png"),
                    Image.asset("assets/images/Moon.png", color: provider.themeMode == ThemeMode.dark ? Colors.white : null),
                  ],
                  height: 40,
                  indicatorSize: Size(40, 40),
                  style: ToggleStyle(
                    backgroundColor: Colors.transparent,
                    indicatorColor: Theme.of(context).primaryColor,
                    borderColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
