import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:google_solution/screens/profile_screen.dart';
import 'package:google_solution/screens/contact_options_screen.dart';
import 'package:google_solution/screens/settings_screen.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key, this.toPop = false});
  final bool toPop;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.person_2_sharp),
          onPressed: () {
            Navigator.popUntil(
                context, ModalRoute.withName(ContactOptionsScreen.id));
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProfileScreen();
            }));
          },
          iconSize: kBottomIconSize,
          color: kCirclesColor,
          highlightColor: kButtonColor,
        ),
        const SizedBox(width: kBottomIconDistance),
        IconButton(
          icon: Icon(Icons.home_filled),
          onPressed: () {
            Navigator.popUntil(
                context, ModalRoute.withName(ContactOptionsScreen.id));
          },
          iconSize: kBottomIconSize,
          color: kCirclesColor,
          highlightColor: kButtonColor,
        ),
        SizedBox(width: kBottomIconDistance),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.popUntil(
                context, ModalRoute.withName(ContactOptionsScreen.id));
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SettingsScreen();
            }));
          },
          iconSize: kBottomIconSize,
          color: kCirclesColor,
          highlightColor: kButtonColor,
        ),
      ],
    );
  }
}
