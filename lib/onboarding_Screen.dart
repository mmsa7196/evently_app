import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:todo_c13_sun/screens/login/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName="OnboardingScreen";
  const OnboardingScreen({super.key});

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 16.0,
    color: Color(0xff1C1C1C),
    );
    const pageDecoration = PageDecoration(
      imageFlex: 2,
      titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
      color: Color(0xff5669FF),
      ),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.all(0),
      pageColor: Color(0xFFF2FEFF),
      imagePadding: EdgeInsets.symmetric(horizontal: 18),
    );
    return IntroductionScreen(
      globalHeader: Image.asset("assets/images/app_logo.png"),
      dotsFlex: 2,
      dotsDecorator: const DotsDecorator(color: Color(0xff1C1C1C),activeColor: Color(0xff5669FF)),
      globalBackgroundColor: Color(0xFFF2FEFF) ,
      showDoneButton: true,
      onDone: () {
        Navigator.pushNamed(context,LoginScreen.routeName);
      },

      done:  Text("Finish".tr(),
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Color(0xff5669FF),),),
      showNextButton: true,
      next:  Text("Next".tr(),
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Color(0xff5669FF),),),
      showBackButton: true,
      back:  Text("Back".tr(),
      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Color(0xff5669FF),),
      ),
      pages: [
        PageViewModel(
          title: "Find Events That Inspire You".tr(),
          body:
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.".tr(),
          image: _buildImage('OnboardingScreen1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Effortless Event Planning".tr(),
          body:
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.".tr(),
          image: _buildImage('OnboardingScreen1 (2).png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Connect with Friends & Share Moments".tr(),
          body: "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.".tr(),
          image: _buildImage('OnboardingScreen3.png'),
          decoration: pageDecoration,
        ),
      ],
    );
}
}