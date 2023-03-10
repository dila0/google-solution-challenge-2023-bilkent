import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_solution/firebase_options.dart';
import 'package:google_solution/models/callerData.dart';
import 'package:google_solution/screens/call_information_screen.dart';
import 'package:google_solution/screens/contact_details_screen.dart';
import 'package:google_solution/screens/intro_screen.dart';
import 'package:google_solution/screens/main_screen.dart';
import 'package:google_solution/screens/settings_screen.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/firebase_utility.dart';
import 'package:provider/provider.dart';
import 'models/messageData.dart';
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
import 'screens/phone_call_screen.dart';
import 'screens/incoming_call_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (FirebaseAuth.instance.currentUser != null) {
    await FirebaseUtility.refresh();
  }
  runApp(GoogleSolution());
}

class GoogleSolution extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<callerData>(create: (context) => callerData()),
        ChangeNotifierProvider<messageData>(create: (context) => messageData())
      ],
      child: MaterialApp(
        home: (user == null)
            ? IntroScreen()
            : MainPage(), //check if already logged in
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.black87,
            ),
          ),
        ),
        routes: {
          StartScreen.id: (BuildContext context) => StartScreen(),
          SignUpScreen.id: (BuildContext context) => SignUpScreen(),
          SignInScreen.id: (BuildContext context) => SignInScreen(),
          ProfileScreen.id: (BuildContext context) => ProfileScreen(),
          ContactOptionsScreen.id: (BuildContext context) =>
              ContactOptionsScreen(),
          ContactDetailsScreen.id: (BuildContext context) =>
              ContactDetailsScreen(),
          CallScreen.id: (BuildContext context) => CallScreen(),
          IncomingScreen.id: (BuildContext context) => IncomingScreen(),
          CallInfo.id: (BuildContext context) => CallInfo(),
          MainPage.id: (BuildContext context) => MainPage(),
        },
      ),
    );
  }
}
