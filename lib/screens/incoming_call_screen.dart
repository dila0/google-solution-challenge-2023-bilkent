import 'package:flutter/material.dart';
import 'package:google_solution/models/callerData.dart';
import 'package:google_solution/screens/phone_call_screen.dart';
import 'package:google_solution/screens/start_screen.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';
import 'package:line_icons/line_icons.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:provider/provider.dart';
import 'contact_options_screen.dart';

class IncomingScreen extends StatefulWidget{
  static const String id = 'Incoming Call Screen';
  @override
  _IncomingCallScreen createState() => _IncomingCallScreen();
}

class _IncomingCallScreen extends State<IncomingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF4A6A7D),
                Color(0XFF38485F),
              ],
            )
        ),
        child: SafeArea(
          child: Column(
            children: [
              Text("Incoming Call", style: TextStyle(color: Colors.white54),),
              SizedBox(height: 1 * (MediaQuery
                  .of(context)
                  .size
                  .height) / 5),
              Text("  ${Provider.of<callerData>(context).callerName} ❤️",
                  style: kCallerIdTextStyle.copyWith(color: Color(0xFFF7FCF9))),
              Text("Türkiye", style: TextStyle(color: Colors.white70),),
              SizedBox(height: 3 * (MediaQuery
                  .of(context)
                  .size
                  .height) / 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:44),
                    child: SwipeTo(
                        child: AnswerButton(Color(0xFF75C75C),LineIcons.phone),
                        offsetDx: (0.8),
                        onRightSwipe: (){
                          Navigator.pushNamed(context, CallScreen.id);
                        },
                        iconSize: 0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:44),
                    child: SwipeTo(
                        child: AnswerButton(Color(0xFF7FF4B42),LineIcons.phoneSlash),
                        offsetDx: (0.8),
                        onLeftSwipe: (){
                        Navigator.pushNamed(context, ContactOptionsScreen.id);
                      },
                      iconSize: 0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
  Stack AnswerButton(Color colour, IconData icon) {
    return Stack(

        children:  [
          const Positioned(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFFE7E8EA),
            ),
          ),
          Positioned(
              left: 20,
              top: 20,
              child: Icon(icon, color: colour, size: 40, fill: 1,)
          )
        ]
    );
  }
