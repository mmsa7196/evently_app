import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_sun/firebase_options.dart';
import 'package:todo_c13_sun/models/task_model.dart';
import 'package:todo_c13_sun/onboarding_Screen.dart';
import 'package:todo_c13_sun/providers/create_events_provider.dart';
import 'package:todo_c13_sun/providers/maps_provider.dart';
import 'package:todo_c13_sun/providers/my_provider.dart';
import 'package:todo_c13_sun/providers/user_provider.dart';
import 'package:todo_c13_sun/screens/auth/forget_password.dart';
import 'package:todo_c13_sun/screens/create_event/Event_Details/event_details.dart';
import 'package:todo_c13_sun/screens/create_event/picker_location_screen.dart';
import 'package:todo_c13_sun/screens/login/login_screen.dart';
import 'package:todo_c13_sun/screens/auth/register.dart';
import 'package:todo_c13_sun/screens/create_event/create_event.dart';
import 'package:todo_c13_sun/screens/home/home.dart';
import 'package:todo_c13_sun/screens/lets_go_screen.dart';
import 'package:todo_c13_sun/theme/dark_theme.dart';
import 'package:todo_c13_sun/theme/light_theme.dart';
import 'package:todo_c13_sun/theme/theme.dart';



void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  FlutterNativeSplash.remove();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) => MapsProvider()
          ),
        ChangeNotifierProvider(
            create: (context) => CreateEventsProvider(),
        ),

      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
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
    var provider = Provider.of<MyProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    BaseTheme theme = LightTheme();
    BaseTheme darkTheme = DarkTheme();
    return ChangeNotifierProvider(
      create:(context) => MyProvider() ,
      builder: (context, child) {
        var provider = Provider.of<MyProvider>(context);
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          initialRoute: userProvider.firebaseUser != null
              ? HomeScreen.routeName
              : IntroductionScreen.routeName,
          darkTheme: darkTheme.themeData,
          theme: theme.themeData,
          themeMode: provider.themeMode,
          routes: {
            IntroductionScreen.routeName: (context) =>  const IntroductionScreen(),
            OnboardingScreen.routeName:(context)=> const OnboardingScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            RegisterScreen.routeName: (context) => RegisterScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            CreateEventScreen.routeName: (context){
              var event=ModalRoute.of(context)?.settings.arguments as EventModel?;
              return CreateEventScreen(event: event,);
              },
            ForgetPassword.routeName: (context) => ForgetPassword(),
            PickerLocationScreen.routeName:(context) {
              var provider =ModalRoute.of(context)?.settings.arguments as CreateEventsProvider;
              return PickerLocationScreen(provider: provider,);
            },
            EventDetails.routeName: (context) {
              var eventModel=ModalRoute.of(context)?.settings.arguments as EventModel;
              return EventDetails(eventModel: eventModel);
            }
          },
        );
      },
    );
  }
}
