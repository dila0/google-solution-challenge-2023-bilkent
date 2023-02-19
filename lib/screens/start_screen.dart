import 'package:flutter/material.dart';
import 'package:google_solution/screens/phone_call_screen.dart';
import 'package:google_solution/screens/sign_up_screen.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';

String boldText = 'WALK ALONE SAFE';
String buttonText = 'GET STARTED';
String bottomText = 'Have an online friend right next to you. Never worry to walk alone again. We are always by your side!';
String girlWalkingImage = 'images/walking_girl.png';

class StartScreen extends StatefulWidget{
  static const String id = 'Start Screen';
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: <Widget>[

          //top left corner circles
          Circles(),
          Column(
            children: [
              //girl image
              Image.asset(girlWalkingImage,
                height: 250.0,
              ),
              //empty space between girl image and text
              SizedBox(
                height: 40.0,
              ),
              //feel safe text
              Container(
                margin: EdgeInsets.symmetric(horizontal: 45.0),
                child: Text(
                  boldText,
                  style: kWelcomeTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              //empty space between two texts
              SizedBox(
                height: 25.0,
              ),
              //small text
              Container(
                margin: EdgeInsets.symmetric(horizontal: 70.0),
                child: Text(
                  bottomText,
                  style: kStartScreenBottomStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              //empty space between text and button
              SizedBox(
                height: 40.0,
              ),
              //get started button
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: kButtonColor,
                  borderRadius: BorderRadius.all(Radius.circular(kButtonRoundness)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: (){
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    minWidth: 350.0,
                    height: 60.0,
                    child: Text(
                      buttonText,
                      style: kStartScreenButtonTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

