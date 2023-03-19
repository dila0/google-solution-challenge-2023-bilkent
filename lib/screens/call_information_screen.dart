import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';
import 'incoming_call_screen.dart';
import 'package:banner_carousel/banner_carousel.dart';

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
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height) / 25),
              //TODO allign text to left, ben yapamadım.
              //TODO yaptım bu hali iyi mi?? - ati
              child: Text(
                'How does it work?',
                style: kWelcomeTextStyle.copyWith(
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height) / 20),
                child: BannerCarousel(
                  animation: false,
                  height: 3 * (MediaQuery.of(context).size.height) / 8,
                  activeColor: kButtonColor,
                  viewportFraction: 1,
                  customizedBanners: [
                    CardContainer(context,
                        "WHEN YOU ADD A CONTACT TO YOUR LIKED LIST, YOU WILL NOT SEE THIS PAGE AGAIN FOR THE SELECTED CONTACT"),
                    CardContainer(context,
                        "WHEN YOU ADD A CONTACT TO YOUR LIKED LIST, YOU WILL NOT SEE THIS PAGE AGAIN FOR THE SELECTED CONTACT"),
                    CardContainer(context,
                        "WHEN YOU ADD A CONTACT TO YOUR LIKED LIST, YOU WILL NOT SEE THIS PAGE AGAIN FOR THE SELECTED CONTACT")
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height) / 20),
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return IncomingScreen();
                    }));
                  },
                  style: ButtonStyle(),
                  child: Text("START CALL")),
            )
          ],
        ),
      ),
    );
  }

  Container CardContainer(BuildContext context, text) {
    return Container(
      margin: new EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: kContactColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: kCallerIdTextStyle.copyWith(
                fontSize: 20, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
