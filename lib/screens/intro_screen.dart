import 'package:flutter/material.dart';
import 'package:google_solution/screens/sign_up_screen.dart';
import 'package:google_solution/utilities/constants.dart';
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
        "If you ever feel unsafe, just select one of our contact options and have a conversation with it. It understands when you answer the question and it simulates a phone call.",
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
        "When you feel like you better notice your loved ones of your situation without making it obvious, you just say \"Americano\" during the phone call and we text your emergency contacts your current location!",
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
        "You can edit the message that will be sent alongside your location to maximise personalization.",
        pathImage: "images/photo4.png",
        backgroundColor: Color(0xffFDEDF8),

      ),
    );
        listContentConfig.add(
        const ContentConfig(
        title: "HOW DOES IT WORK",
          styleTitle:kWelcomeTextStyle,
          styleDescription: kIntroDescriptionStyle,

        description:
        "Do not forget to select your emergency contacts in the settings page after you signed-up to maximize the benefits of Lunaris!",
        pathImage: "images/photo5.png",
          backgroundColor: Color(0xffFDEDF8),

    ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "LETS GET STARTED!",
        styleTitle:kWelcomeTextStyle,
        styleDescription: kIntroDescriptionStyle,

        description:
        "It doesn't matter if you are walking alone at night or you wish to leave a place that you feel uncomfortable in... \n\nLunaris is here to help you!",
        pathImage: "images/photo5.png",
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