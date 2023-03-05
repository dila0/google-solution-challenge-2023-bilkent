import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';
import 'package:google_solution/utilities/bottom_bar.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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

  void changeColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Pick Your Profile Picture Color',
          textAlign: TextAlign.center,
          style: kProfilePopUpStyle,
        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: <Widget>[
          const Circles(),
          Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: myColor,
                    boxShadow: [
                      BoxShadow(
                        color: myColor.withOpacity(0.8),
                        blurRadius: 3.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.33,
                  height: MediaQuery.of(context).size.width * 0.33,
                ),
                TextButton(
                  child: const Text(
                    'Select Profile Picture Color',
                    style: kProfileButton,
                  ),
                  onPressed: () {
                    changeColor(context);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.07,
                ),
                ProfilePageContainer(
                  iconName: Icon(Icons.account_circle_rounded),
                  profileNameString: 'Name: ',
                  userNameString: '@namesurname',
                  widthBetween: 34.0,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                ProfilePageContainer(
                  widthBetween: 0,
                  iconName: Icon(Icons.mail),
                  profileNameString: 'Mail Address: ',
                  userNameString: '@mailaddress',
                  //TODO: Sadece başı alınacak mailin
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                EmergencyContactContainer(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.055),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.15,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Material(
                    color: kButtonColor,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(kButtonRoundness)),
                    elevation: 3.0,
                    child: TextButton(
                      onPressed: () {
                        print('DO STH');
                        //TODO: go to saved audio
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.015,
                          ),
                          Opacity(
                            opacity: 0.8,
                            child: Image.asset(
                              'images/heart.png',
                              width: MediaQuery.of(context).size.height * 0.15,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('SAVED', style: kSavedAudioTextStyle),
                              Text('AUDIO', style: kSavedAudioTextStyle),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
