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
import 'package:line_icons/line_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'incoming_call_screen.dart';
import 'package:google_solution/utilities/firebase_utility.dart';

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
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EmergencyScreen();
    }));
    print("Emergency pressed");
  }

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    String userName = "${FirebaseUtility.name} ${FirebaseUtility.surname}";
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: SliverAppBar(
              stretch: true,
              title: const Circles(),
              backgroundColor: kBackgroundColor,
              elevation: 0,
              toolbarHeight: MediaQuery.of(context).size.height / 6,
              centerTitle: false,
              titleSpacing: 0,
              automaticallyImplyLeading: false,
            ),
          ),
        ],
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
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
                    Center(child: Text(startText, style: kSignUpInScreen)),
                    Expanded(
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.height / 40),
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: [
                                ContactCard(
                                  page: CallInfo(),
                                  imageUrl: 'images/mom_daughter.png',
                                  contactName: 'MOM <3',
                                  durationText: '2min',
                                  utilitiesText:
                                      'A two minute relaxing audio with your mom while walking',
                                ),
                                SizedBox(height: 10.0),
                                ContactCard(
                                  page: CallInfo(),
                                  imageUrl: 'images/dad_girl.png',
                                  contactName: 'DAD <3',
                                  durationText: '2min',
                                  utilitiesText:
                                      'A two minute relaxing audio with your dad while walking',
                                ),
                                SizedBox(height: 10.0),
                                ContactCard(
                                  page: CallInfo(),
                                  imageUrl: 'images/bestie.png',
                                  contactName: 'BESTIE <3',
                                  durationText: '2min',
                                  utilitiesText:
                                      'A two minute relaxing audio with your best friend while walking',
                                ),
                                SizedBox(height: 10.0),
                                ContactCard(
                                  page: CallInfo(),
                                  imageUrl: 'images/lovers.png',
                                  contactName: 'LOVER <3',
                                  durationText: '2min',
                                  utilitiesText:
                                      'A two minute relaxing audio with your lover while walking',
                                ),
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
