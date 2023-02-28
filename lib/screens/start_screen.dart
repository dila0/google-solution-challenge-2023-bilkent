import 'package:flutter/material.dart';
import 'package:google_solution/screens/sign_up_screen.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';

String boldText = 'WALK ALONE SAFE';
String buttonText = 'GET STARTED';
String bottomText =
    'Have an online friend right next to you. Never worry to walk alone again. We are always by your side!';
String girlWalkingImage = 'images/walking_girl.png';

class StartScreen extends StatefulWidget {
  static const String id = 'Start Screen';
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //top left corner circles
          Circles(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //girl image
                Image.asset(
                  girlWalkingImage,
                  height: MediaQuery.of(context).size.height / 2.5,
                ),

                //feel safe text
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height / 18),
                  child: Text(
                    boldText,
                    style: kWelcomeTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                //small text
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height / 12),
                  child: Text(
                    bottomText,
                    style: kStartScreenBottomStyle,
                    textAlign: TextAlign.center,
                  ),
                ),

                //get started button
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 50),
                  child: Material(
                    color: kButtonColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(kButtonRoundness)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      minWidth: MediaQuery.of(context).size.height / 2,
                      height: MediaQuery.of(context).size.height / 12,
                      child: Text(
                        buttonText,
                        style: kStartScreenButtonTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
