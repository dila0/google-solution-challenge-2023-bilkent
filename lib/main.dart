import 'package:flutter/material.dart';
import 'package:google_solution/screens/settings_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/contact_options_screen.dart';
import 'screens/start_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/emergency_call.dart';
import 'contact_options/mom_screen.dart';
import 'contact_options/dad_screen.dart';
import 'contact_options/bestie_screen.dart';
import 'contact_options/lover_screen.dart';

void main() {
  runApp (GoogleSolution());
}

class GoogleSolution extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
      routes: {
        StartScreen.id: (context) => StartScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        SignInScreen.id: (context) => SignInScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        ContactOptionsScreen.id: (context) => ContactOptionsScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        EmergencyScreen.id: (context) => EmergencyScreen(),
        DadScreen.id: (context) => DadScreen(),
        MomScreen.id: (context) => MomScreen(),
        LoverScreen.id: (context) => LoverScreen(),
        BestieScreen.id: (context) => BestieScreen(),
      },
    );
  }
}


