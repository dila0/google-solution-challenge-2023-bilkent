import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_solution/models/messageData.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';
import 'package:google_solution/utilities/bottom_bar.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_solution/utilities/firebase_utility.dart';
import 'package:google_solution/utilities/profile_container.dart';
import 'package:google_solution/utilities/emergency_contact.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'Profile Screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget buildColorPicker() {
    return ColorPicker(
        pickerColor: myColor,
        onColorChanged: (color) {
          setState(() {
            myColor = color;
          });
        });
  }

  void changeCustomMesssage() {
    setState(() {});
  }

  void changeColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildColorPicker(),
            TextButton(
              child: Text(
                'SELECT',
                style: TextStyle(
                  fontSize: 20.0,
                  color: kButtonColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Color myColor = kButtonColor;
  bool isEnabled = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            const Circles(),
            Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  GestureDetector(
                    onTap: () {
                      changeColor(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: myColor,
                        boxShadow: [
                          BoxShadow(
                            color: myColor.withOpacity(0.8),
                            blurRadius: .2,
                            spreadRadius: .8,
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 0.33,
                      height: MediaQuery.of(context).size.width * 0.33,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.07,
                  ),
                  ProfilePageContainer(
                    iconName: const Icon(Icons.account_circle_rounded),
                    profileNameString: 'Name: ',
                    userNameString: FirebaseUtility.name,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  ProfilePageContainer(
                    iconName: const Icon(Icons.mail),
                    profileNameString: 'Mail Address: ',
                    userNameString: user == null ? '' : user.email ?? 'Error',
                    //TODO: Sadece başı alınacak mailin
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                  EmergencyContactContainer(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isEnabled = true;
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.08,
                                  vertical: MediaQuery.of(context).size.width *
                                      0.008),
                              child: Row(
                                children: const [
                                  Text('Edit Message',
                                      style:
                                          kEditTextStyle) //TODO mayge change the whole thing with emergency_contact_textfield.dart
                                ],
                              ))),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          color: Colors.white60,
                          //height: 3*(MediaQuery.of(context).size.height)/17,
                          child: Material(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(kButtonRoundness)),
                              elevation: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  onTapOutside: (_) {
                                    setState(() {
                                      isEnabled = false;
                                    });
                                  },
                                  autofocus: true,
                                  controller: TextEditingController(),
                                  onSubmitted: (value) {
                                    setState(() {
                                      // db.put('message', value);
                                      FirebaseUtility.updateCustomMessage(
                                          value);
                                      FirebaseUtility.customMessage =
                                          FirebaseUtility.customMessage;
                                      isEnabled = false;
                                    });
                                  },
                                  //minLines: 1,
                                  maxLines: null,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    enabled: isEnabled,
                                    border: InputBorder.none,
                                    hintText:
                                        '  ${FirebaseUtility.customMessage}',
                                    hintMaxLines: 8,
                                  ),
                                ),
                              )))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
