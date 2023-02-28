import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';
import '../models/callerData.dart';
import 'contact_options_screen.dart';
import 'incoming_call_screen.dart';

class CallInfo extends StatefulWidget {
  static const String id = 'Call Information Screen';
  @override
  _CallInfoState createState() => _CallInfoState();
}

class _CallInfoState extends State<CallInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              //TODO allign text to left, ben yapamadım.
              //TODO yaptım bu hali iyi mi?? - ati
              child: Text(
                'How does it work?',
                style: kWelcomeTextStyle.copyWith(
                  fontSize: 30,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height) / 30),
              child: Container(
                margin: new EdgeInsets.symmetric(horizontal: 15.0),
                height: 3 * (MediaQuery.of(context).size.height) / 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: kContactColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height) / 60),
              child: Container(
                color: Color(0xAFF3B5CB),
                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "  ** WHEN YOU ADD A CONTACT TO YOUR LIKED LIST, YOU WILL NOT SEE THIS PAGE AGAIN FOR THE SELECTED CONTACT **  ",
                  style: kWelcomeTextStyle.copyWith(
                      fontSize: 15, color: Colors.black87),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, IncomingScreen.id);
                },
                child: Text("START CALL"))
          ],
        ),
      ),
    );
  }
}
