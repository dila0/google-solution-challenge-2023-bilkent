import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:google_solution/screens/profile_screen.dart';
import 'package:google_solution/screens/contact_options_screen.dart';
import 'package:google_solution/screens/settings_screen.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.person_2_sharp),
          onPressed: (){
            if(ModalRoute.of(context)?.settings.name != ProfileScreen.id){
              Navigator.pushNamed(context, ProfileScreen.id);
              }
          },
          iconSize: kBottomIconSize,
          color: kCirclesColor,
          highlightColor: kButtonColor,
        ),
        const SizedBox(width: kBottomIconDistance),
        IconButton(
          icon: Icon(Icons.home_filled),
          onPressed: (){
            if(ModalRoute.of(context)?.settings.name != ContactOptionsScreen.id){
              Navigator.pushNamed(context, ContactOptionsScreen.id);
            }
          },
          iconSize: kBottomIconSize,
          color: kCirclesColor,
          highlightColor: kButtonColor,
        ),
        SizedBox(width: kBottomIconDistance),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: (){
            if(ModalRoute.of(context)?.settings.name != SettingsScreen.id){
              Navigator.pushNamed(context, SettingsScreen.id);
            }
          },
          iconSize: kBottomIconSize,
          color: kCirclesColor,
          highlightColor: kButtonColor,
        ),
      ],
    );
  }
}
