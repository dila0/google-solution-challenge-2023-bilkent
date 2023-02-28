import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_solution/screens/call_information_screen.dart';
import 'package:google_solution/screens/emergency_call.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';
import 'package:google_solution/utilities/contact_card.dart';
import 'package:google_solution/utilities/bottom_bar.dart';
import 'package:google_solution/utilities/register_button.dart';
import 'package:google_solution/contact_options/mom_screen.dart';
import 'package:google_solution/contact_options/dad_screen.dart';
import 'package:google_solution/contact_options/lover_screen.dart';
import 'package:google_solution/contact_options/bestie_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'incoming_call_screen.dart';

String startText = 'CONTACT OPTIONS';
String welcomeString = 'Welcome';

class ContactOptionsScreen extends StatefulWidget {
  static const String id = 'Contact Options Screen';

  @override
  _ContactOptionsScreenState createState() => _ContactOptionsScreenState();
}

class _ContactOptionsScreenState extends State<ContactOptionsScreen> {
  void emergencyPressed() {
    //TODO emergency function
    Navigator.pushNamed(context, EmergencyScreen.id);
    print("Emergency pressed");
  }

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final String userName = user?.displayName ?? 'Unnamed';
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        //TODO her şeyi scrollview içine mi alsak? welcome falan da kaysa, sliver appbar diye bişey var ondan yapılabilir
        children: <Widget>[
          const Circles(),
          Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: kSignUpScreenDistanceFromTop),
                Center(
                    child: Text(
                  welcomeString,
                  style: kSignUpInfoStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.height / 20),
                )),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: MediaQuery.of(context).size.height / 15),
                  child: Center(
                      child: Text(
                    userName,
                    style: kSignUpInfoStyle.copyWith(
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center,
                  )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40),
                Text(startText, style: kSignUpInScreen),
                Expanded(
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.height / 40),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: [
                            ContactCard(
                              routeName: CallInfo.id,
                              imageUrl: 'images/mom_daughter.png',
                              contactName: 'MOM <3',
                              durationText: '2min',
                              utilitiesText:
                                  'A two minute relaxing audio with your mom while walking',
                            ),
                            SizedBox(height: 10.0),
                            ContactCard(
                              routeName: CallInfo.id,
                              imageUrl: 'images/dad_girl.png',
                              contactName: 'DAD <3',
                              durationText: '2min',
                              utilitiesText:
                                  'A two minute relaxing audio with your dad while walking',
                            ),
                            SizedBox(height: 10.0),
                            ContactCard(
                              routeName: CallInfo.id,
                              imageUrl: 'images/bestie.png',
                              contactName: 'BESTIE <3',
                              durationText: '2min',
                              utilitiesText:
                                  'A two minute relaxing audio with your best friend while walking',
                            ),
                            SizedBox(height: 10.0),
                            ContactCard(
                              routeName: CallInfo.id,
                              imageUrl: 'images/lovers.png',
                              contactName: 'LOVER <3',
                              durationText: '2min',
                              utilitiesText:
                                  'A two minute relaxing audio with your lover while walking',
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 8),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height / 40),
                              child: RegisterButton(
                                title: 'EMERGENCY CALL',
                                minWidth:
                                    MediaQuery.of(context).size.height / 2,
                                height: MediaQuery.of(context).size.height / 12,
                                pressedFunct: emergencyPressed,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        color: kBackgroundColor,
        child: BottomBar(),
      ),
    );
  }
}
