import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_sun/onboarding_Screen.dart';
import 'package:todo_c13_sun/providers/my_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';


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
        padding: const EdgeInsets.only(
          bottom: 18.0,
          right: 18,
          left: 18,
        ),
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, OnboardingScreen.routeName);
            },
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: Color(0xFF5669FF)),
            child: Text(
              "lets_start".tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
            )),
      ),
      appBar: AppBar(
        backgroundColor:Theme.of(context).scaffoldBackgroundColor,
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
            SizedBox(
              height: 28,
            ),
            Text(
              context.tr('introduction_title'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 28,
            ),
            Text(
              "introduction_description".tr(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Color(0xFF1C1C1C) ,
                  ),
            ),
            SizedBox(
              height: 28,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "language".tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ToggleSwitch(
                  minWidth: 73.0,
                  minHeight: 30.0,
                  initialLabelIndex: 0,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  icons: [
                    context.locale.toString() == "en"
                        ? FontAwesomeIcons.flagUsa
                        : MdiIcons.abjadArabic,
                    context.locale.toString() != "en"
                        ? FontAwesomeIcons.flagUsa
                        : MdiIcons.abjadArabic,
                  ],
                  iconSize: 30.0,
                  activeBgColors: [
                    context.locale.toString() == "en"
                        ? [
                            Theme.of(context).primaryColor,
                            Theme.of(context).hintColor
                          ]
                        : [Colors.yellow, Colors.orange],
                    context.locale.toString() == "en"
                        ? [
                            Theme.of(context).primaryColor,
                            Theme.of(context).hintColor
                          ]
                        : [Colors.yellow, Colors.orange],
                  ],
                  animate: true,
                  curve: Curves.bounceInOut,
                  onToggle: (index) {
                    if (context.locale.toString() == "en") {
                      if (index == 0) {
                        context.setLocale(Locale('en'));
                      } else {
                        context.setLocale(Locale('ar'));
                      }
                    } else {
                      if (index == 1) {
                        context.setLocale(Locale('en'));
                      } else {
                        context.setLocale(Locale('ar'));
                      }
                    }
                  },
                ),
              ], // en >> 0 , ar >> 1
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "theme".tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ToggleSwitch(
                  minWidth: 73.0,
                  minHeight: 30.0,
                  initialLabelIndex: 0,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  icons: [
                    provider.themeMode == ThemeMode.light
                        ? MdiIcons.lightbulb
                        : FontAwesomeIcons.moon,
                    provider.themeMode != ThemeMode.light
                        ? MdiIcons.lightbulb
                        : FontAwesomeIcons.moon,
                  ],
                  iconSize: 30.0,
                  activeBgColors: [
                    provider.themeMode == ThemeMode.light
                        ? [Colors.yellow, Colors.orange]
                        : [
                            Theme.of(context).primaryColor,
                            Theme.of(context).hintColor
                          ],
                    provider.themeMode != ThemeMode.light
                        ? [Colors.yellow, Colors.orange]
                        : [
                            Theme.of(context).primaryColor,
                            Theme.of(context).hintColor
                          ],
                  ],
                  animate: true,
                  curve: Curves.bounceInOut,
                  onToggle: (index) {
                    provider.changeTheme();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
