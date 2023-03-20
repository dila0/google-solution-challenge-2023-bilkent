import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:google_solution/screens/call_information_screen.dart';
import 'package:google_solution/screens/emergency_call.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';
import 'package:google_solution/utilities/contact_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_solution/utilities/register_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_solution/utilities/firebase_utility.dart';
import 'package:vibration/vibration.dart';
String startText = 'CONTACT OPTIONS';
String welcomeString = 'Welcome';
List<String> contacts = FirebaseUtility.contacts;
String message = FirebaseUtility.customMessage;
bool isDone = false;

class ContactOptionsScreen extends StatefulWidget {
  static const String id = 'Contact Options Screen';

  @override
  _ContactOptionsScreenState createState() => _ContactOptionsScreenState();
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  return position;
}

class _ContactOptionsScreenState extends State<ContactOptionsScreen> {
  int _counter = 0;
  StreamController<int>? _events;
  Position? position;
  @override
  initState() {
    super.initState();
    _events = new StreamController<int>();
    _events?.add(5);
    Future<Position> pos;
    if (position == null) {
      pos = _determinePosition();
      _determinePosition().then((Position s) => setState(() {
            //TODO RETURNED NULL is it fine?
            position = s;
          }));
    }
  }

  Timer? _timer;
  void _stopTimer() {
    if (_timer == null) return;

    _timer?.cancel();
  }

  void _startTimer() async{
    _counter = 5;

    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //setState(() {
      if (_counter > 0) {
        _counter--;
      } else {
        _events?.close();
        _events = new StreamController<int>();
        _events?.add(5);
        Navigator.pop(context, 'OK');
        Future<String> _result = sendSMS(message: message, recipients: contacts, sendDirect: true)
            .catchError((onError) {
          print(onError);
        });
        print(_result);
        //String didSend = await sendSMS(message: message, recipients: contacts,sendDirect: true);
        launchUrl(Uri.parse("tel://112"));
        setState(() {
          isDone = true;
        });
        _timer?.cancel();
      }
      //});
      print(_counter);
      _events?.add(_counter);
    });
  }

  void alertD(BuildContext ctx, Position position) {
    var alert = AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
        content: StreamBuilder<int>(
            stream: _events?.stream,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              print(snapshot.data.toString());
              return Container(
                height: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 15),
                        child: Text(
                          'WARNING',
                          style: TextStyle(
                              color: kCallContainerColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                    Text(
                      'MESSAGE WILL BE SENT TO YOUR CONTACT AND 112 WILL BE CALLED',
                      style: kWarningTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                        '${(snapshot.data == null || snapshot.data.toString() == '0') ? '5' : snapshot?.data.toString()}'),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context, 'OK');
                                _stopTimer();
                                _events?.close();
                                _events = new StreamController<int>.broadcast();
                                _events?.add(5);
                              },
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: kButtonColor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                    child: Text(
                                  'CANCEL',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Material(
                            child: InkWell(
                              onTap: () async {
                                _stopTimer();
                                _events?.close();
                                _events = new StreamController<int>.broadcast();
                                _events?.add(5);
                                if(position != null)
                                Future <String> res = sendSMS(
                                    message:
                                        "$message   https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}.",
                                    recipients: contacts, sendDirect: true).catchError((onError) {
                                  print(onError);
                                });
                                else {
                                  Future <String> res = sendSMS(
                                      message:
                                      "$message   https://www.google.com/maps/search/?api=1&query=${position
                                          .latitude},${position.longitude}.",
                                      recipients: contacts, sendDirect: true)
                                      .catchError((onError) {
                                    print(onError);
                                  });
                                }
                                if ( await Vibration.hasVibrator() ?? false) {
                                Vibration.vibrate();
                                }
                                //launchUrl(Uri.parse("tel://112"));
                                Navigator.pop(context, 'OK');
                              },
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: kButtonColor),
                                child: const Center(
                                  child: Text(
                                    'OKAY',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ), //new column child
                  ],
                ),
              );
            }));
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return alert;
        });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
    if(position == null){
      return CircularProgressIndicator();
    }
    else {
      final user = _auth.currentUser;
      String userName = "${FirebaseUtility.name} ${FirebaseUtility.surname}";
      return Scaffold(
          backgroundColor: kBackgroundColor,
          body: Stack(
            children: [
              NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) => [
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
                    //TODO her şeyi scrollview içine mi alsak? welcome falan da kaysa, sliver appbar diye bişey var ondan yapılabilir
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                            Center(
                                child: Text(
                              welcomeString,
                              style: kSignUpInfoStyle.copyWith(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 20),
                            )),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal:
                                      MediaQuery.of(context).size.height / 15),
                              child: Center(
                                  child: Text(
                                userName,
                                style: kSignUpInfoStyle.copyWith(
                                  fontSize: 40,
                                ),
                                textAlign: TextAlign.center,
                              )),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 40),
                            Center(
                                child: Text(startText, style: kSignUpInScreen)),
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
                                    contactName: 'MOM',
                                    durationText: '2min',
                                    utilitiesText:
                                        'A two minute relaxing audio with your mom while walking',
                                  ),
                                  const SizedBox(height: 10.0),
                                  ContactCard(
                                    page: CallInfo(),
                                    imageUrl: 'images/dad_girl.png',
                                    contactName: 'DAD',
                                    durationText: '2min',
                                    utilitiesText:
                                        'A two minute relaxing audio with your dad while walking',
                                  ),
                                  const SizedBox(height: 10.0),
                                  ContactCard(
                                    page: CallInfo(),
                                    imageUrl: 'images/bestie.png',
                                    contactName: 'BESTIE',
                                    durationText: '2min',
                                    utilitiesText:
                                        'A two minute relaxing audio with your best friend while walking',
                                  ),
                                  const SizedBox(height: 10.0),
                                  ContactCard(
                                    page: CallInfo(),
                                    imageUrl: 'images/lovers.png',
                                    contactName: 'LOVER',
                                    durationText: '2min',
                                    utilitiesText:
                                        'A two minute relaxing audio with your lover while walking',
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 40),
                        child: RegisterButton(
                            title: 'EMERGENCY CALL',
                            minWidth: MediaQuery.of(context).size.height / 2,
                            height: MediaQuery.of(context).size.height / 12,
                            pressedFunct: () => {
                                  _startTimer(),
                                  alertD(context, position!),
                                }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ));
    }
  }
}
/*
() => showDialog<String>(
context: context,
builder: (BuildContext context) => AlertDialog(
title: const Text('WARNING'),
content: const Text('112 will be called and your contacts will be notified?'),
actions: <Widget>[
TextButton(
onPressed: () => Navigator.pop(context, 'Cancel'),
child: const Text('Cancel'),
),
TextButton(
onPressed: () => {
sendSMS(message: message, recipients: contacts),
launchUrl(Uri.parse("tel://112")),
Navigator.pop(context, 'OK')
},
child: const Text('OK'),
),
],
),
),
*/
