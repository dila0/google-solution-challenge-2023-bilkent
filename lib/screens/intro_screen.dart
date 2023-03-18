import 'package:flutter/material.dart';
import 'package:google_solution/screens/sign_up_screen.dart';
import 'package:google_solution/screens/start_screen.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroScreen extends StatefulWidget{
  static const String id = 'Intro Screen';
  @override
  _IntroScreen createState() => _IntroScreen();
}

class _IntroScreen extends State<IntroScreen>{
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      const ContentConfig(
        title: "WHAT IS LUNARIS?",
        styleTitle:kWelcomeTextStyle,
        styleDescription: kIntroDescriptionStyle,
        description:
        "Lunaris is an application for you to have phone calls in unwanted situations or when you are walking alone on the street.",
        //textAlignDescription: TextAlign.left,
        pathImage: "images/photo1.png",
        backgroundColor: Color(0xffFDEDF8),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "HOW DOES IT WORK",
        styleTitle:kWelcomeTextStyle,
        styleDescription: kIntroDescriptionStyle,
        description:
        "If you ever feel unsafe, just select one of the pre-saved contact options and have a real cht with it. It understands when you answer the question and simulates a phone call.",
        pathImage: "images/photo2.png",
        backgroundColor: Color(0xffFDEDF8),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "HOW DOES IT WORK",
        styleTitle:kWelcomeTextStyle,
        styleDescription: kIntroDescriptionStyle,
        description:
        "When you feel like you must notice your loved ones that you're feeling in danger or you may not be safe without making it obvious, you just say \"Americano\" and we text your emergency contacts your current location.!",
        pathImage: "images/photo3.png",
        backgroundColor: Color(0xffFDEDF8),
      ),
    );
        listContentConfig.add(
        const ContentConfig(
        title: "HOW DOES IT WORK",
          styleTitle:kWelcomeTextStyle,
          styleDescription: kIntroDescriptionStyle,

        description:
        "Do not forget to select your emergency contacts in the settings page after you signed-up to maximize the benefits of uygulama adı!",
        pathImage: "images/photo4.png",
          backgroundColor: Color(0xffFDEDF8),

    ),
    );
  }

  void onDonePress() {
    Navigator.pushNamed(context, SignUpScreen.id);
  }
  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: listContentConfig,
      onDonePress: onDonePress,
    );
  }
}