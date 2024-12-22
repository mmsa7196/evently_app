import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_sun/providers/my_provider.dart';
import 'package:todo_c13_sun/screens/lets_go_screen.dart';
import 'package:todo_c13_sun/theme/dark_theme.dart';
import 'package:todo_c13_sun/theme/light_theme.dart';
import 'package:todo_c13_sun/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: EasyLocalization(
        supportedLocales: [
          const Locale('en'),
          const Locale('ar'),
        ],
        path: 'assets/translations',
        // <-- change the path of the translation files
        fallbackLocale: const Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    BaseTheme theme = LightTheme();
    BaseTheme darkTheme = DarkTheme();
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      initialRoute: IntroductionScreen.routeName,
      darkTheme: darkTheme.themeData,
      theme: theme.themeData,
      themeMode: provider.themeMode,
      routes: {
        IntroductionScreen.routeName: (context) => const IntroductionScreen(),
      },
    );
  }
}
