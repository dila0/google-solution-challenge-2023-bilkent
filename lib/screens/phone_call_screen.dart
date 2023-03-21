import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/snack_bar_utility.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';
import '../models/callerData.dart';
import '../utilities/audioListener.dart';
import '../utilities/firebase_utility.dart';
import '../utilities/register_button.dart';
import 'contact_options_screen.dart';

List<String> contacts = FirebaseUtility.contacts;
String message = FirebaseUtility.customMessage;

class CallScreen extends StatefulWidget {
  static const String id = 'Call Screen';
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("0");
  int _counter = 0;
  StreamController<int>? _events;
  Position? position;
  late audioListener listener;
  Timer? _timer;
  late SharedPreferences prefs;
  late bool wordDetectionEnabled;
  int _soundCounter = 1;
  String? contact;
  int soundCount = 0;

  void getPreferences() {
    prefs = FirebaseUtility.prefs;
    setState(() {
      wordDetectionEnabled = prefs.getBool('triggerWord') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    listener = audioListener(
        emergency, userStoppedTalking, showErrorSnackbar, audioPlayer);
    getPreferences();
    listener.startNoiseMeter();
    if (wordDetectionEnabled) {
      listener.startPorcupine();
    }

    contact = Provider.of<callerData>(context, listen: false).callerName;
    soundCount =
        Provider.of<callerData>(context, listen: false).getSoundNumber();
    audioPlayer.open(
      Audio("sounds/$contact$_soundCounter.mp3"),
      autoStart: true,
      showNotification: true,
      loopMode: LoopMode.none,
    );
    // audioPlayer.open(
    //   Audio("sounds/DAD1.mp3"),
    //   autoStart: true,
    //   showNotification: true,
    //   loopMode: LoopMode.none,
    // );
  }

  void showErrorSnackbar(String title, String message) {
    SnackBarUtility.showFailureSnackBar(context, message, title);
  }

  void _stopTimer() {
    if (_timer == null) return;

    _timer?.cancel();
  }

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

  void emergency() async {
    //_startTimer();
    //alertD(context, position! );

    position = await _determinePosition();

    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }

    Future<String> res = sendSMS(
            message:
                "${FirebaseUtility.customMessage} https://www.google.com/maps/search/?api=1&query=${position?.latitude},${position?.longitude}.",
            recipients: contacts,
            sendDirect: true)
        .catchError((onError) {
      print(onError);
    });
  }

  void userStoppedTalking() {
    if (audioPlayer.isPlaying.value) {
      return;
    }
    if (audioPlayer == null) return;
    _soundCounter++;
    if (_soundCounter <= soundCount) {
      audioPlayer.open(
        Audio("sounds/$contact$_soundCounter.mp3"),
        //autoStart: true,
        showNotification: true,
        loopMode: LoopMode.none,
      );
      audioPlayer.play();
    }
  }

  void _startTimer() {
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
        sendSMS(message: message, recipients: contacts);
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
                    const Padding(
                        padding: EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 15),
                        child: Text(
                          'WARNING',
                          style: TextStyle(
                              color: kCallContainerColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                    const Text(
                      'MESSAGE WILL BE SENT TO YOUR CONTACT AND 112 WILL BE CALLED',
                      style: kWarningTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                        '${(snapshot.data == null || snapshot.data.toString() == '0') ? '5' : snapshot?.data.toString()}'),
                    const SizedBox(
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
                                _stopTimer();
                                _events?.close();
                                _events = StreamController<int>.broadcast();
                                _events?.add(5);
                              },
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: kButtonColor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: const Center(
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
                              onTap: () {
                                _stopTimer();
                                _events?.close();
                                _events = StreamController<int>.broadcast();
                                _events?.add(5);
                                sendSMS(
                                    message:
                                        "$message   https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}.",
                                    recipients: contacts);
                                launchUrl(Uri.parse("tel://112"));
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
    listener.stopNoiseMeter();
    listener.stopPorcupine();
  }

  @override
  Widget build(BuildContext context) {
    // contact = Provider.of<callerData>(context).callerName;
    // soundCount = Provider.of<callerData>(context).getSoundNumber();
    // audioPlayer.open(
    //   Audio("sounds/$contact$soundCount.mp3"),
    //   autoStart: true,
    //   showNotification: true,
    //   loopMode: LoopMode.none,
    // );
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF4A6A7D),
            Color(0XFF38485F),
          ],
        )),
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.white60,
                          size: MediaQuery.of(context).size.height / 20,
                        ),
                        Text(
                          "  00:00",
                          style: TextStyle(color: Colors.white60),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 24,
                    ),
                    Text("${Provider.of<callerData>(context).callerName}) ❤️",
                        style: kCallerIdTextStyle),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.height / 10,
                      backgroundImage: ExactAssetImage('images/father.jpg'),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 11,
                    )
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 3 * (MediaQuery.of(context).size.height / 7),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height / 40),
                    color: kCallContainerColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconWidget(
                            iconPath: LineIcons.microphoneSlash,
                            iconDescription: "Mute",
                            size: MediaQuery.of(context).size.height / 20,
                          ),
                          IconWidget(
                            iconPath: Icons.pause_rounded,
                            iconDescription: "Hold",
                            size: MediaQuery.of(context).size.height / 20,
                          ),
                          IconWidget(
                            iconPath: Icons.note_alt_outlined,
                            iconDescription: "Note",
                            size: MediaQuery.of(context).size.height / 20,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconWidget(
                            iconPath: LineIcons.volumeUp,
                            iconDescription: "Speaker",
                            size: MediaQuery.of(context).size.height / 20,
                          ),
                          IconWidget(
                            iconPath: LineIcons.plus,
                            iconDescription: "Add call",
                            size: MediaQuery.of(context).size.height / 20,
                          ),
                          IconWidget(
                            iconPath: LineIcons.braille,
                            iconDescription: "Keypad",
                            size: MediaQuery.of(context).size.height / 20,
                          ),
                        ],
                      ),
                      Visibility(
                        visible: !wordDetectionEnabled,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RegisterButton(
                              color: kCallButtonColor,
                              title: 'ALERT CONTACTS',
                              minWidth: MediaQuery.of(context).size.height / 2,
                              height: MediaQuery.of(context).size.height / 12,
                              pressedFunct: () => {emergency()}),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          audioPlayer.stop();
                          audioPlayer.dispose();
                        },
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.height / 20,
                          backgroundColor: Color(0xDFFF2323),
                          child: Icon(LineIcons.phoneSlash),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget(
      {super.key,
      required this.iconPath,
      required this.iconDescription,
      this.size = 45});
  final double size;
  final IconData iconPath;
  final String iconDescription;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          iconPath,
          color: Colors.white70,
          size: size,
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 120),
        Text(
          iconDescription,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
