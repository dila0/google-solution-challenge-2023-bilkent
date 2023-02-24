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

import 'incoming_call_screen.dart';

String startText = 'CONTACT OPTIONS';

class ContactOptionsScreen extends StatefulWidget{
  static const String id = 'Contact Options Screen';
  @override
  _ContactOptionsScreenState createState() => _ContactOptionsScreenState();
}

class _ContactOptionsScreenState extends State<ContactOptionsScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: <Widget>[
          const Circles(),
          Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: kSignUpScreenDistanceFromTop),
                Text(startText, style: kSignUpInScreen),
                Expanded(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: const [
                            ContactCard(
                              routeName: CallInfo.id,
                              imageUrl: 'images/mom_daughter.png',
                              contactName: 'MOM <3',
                              durationText: '2min',
                              utilitiesText: 'A two minute relaxing audio with your mom while walking',
                            ),
                            SizedBox(height: 10.0),
                            ContactCard(
                              routeName: CallInfo.id,
                              imageUrl: 'images/dad_girl.png',
                              contactName: 'DAD <3',
                              durationText: '2min',
                              utilitiesText: 'A two minute relaxing audio with your dad while walking',

                            ),
                            SizedBox(height: 10.0),
                            ContactCard(
                              routeName: CallInfo.id,
                              imageUrl: 'images/bestie.png',
                              contactName: 'BESTIE <3',
                              durationText: '2min',
                              utilitiesText: 'A two minute relaxing audio with your best friend while walking',
                            ),
                            SizedBox(height: 10.0),
                            ContactCard(
                              routeName: CallInfo.id,
                              imageUrl: 'images/lovers.png',
                              contactName: 'LOVER <3',
                              durationText: '2min',
                              utilitiesText: 'A two minute relaxing audio with your lover while walking',
                            ),
                            SizedBox(height: 60.0),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: RegisterButton(
                                title: 'EMERGENCY CALL',
                                routeName: EmergencyScreen.id,
                                minWidth: 350.0,
                                height: 60.0,
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