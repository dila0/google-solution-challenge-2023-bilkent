import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

import '../models/callerData.dart';
import 'contact_options_screen.dart';
import 'incoming_call_screen.dart';

class CallScreen extends StatefulWidget {
  static const String id = 'Call Screen';
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
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
                child: Expanded(
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
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
