import 'package:flutter/material.dart';
import 'package:google_solution/screens/incoming_call_screen.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';
import 'package:google_solution/utilities/register_button.dart';
import 'package:google_solution/utilities/register_text_field.dart';
import 'package:google_solution/utilities/bottom_text_sign_in.dart';
import 'sign_in_screen.dart';
import 'contact_options_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_solution/firebase_options.dart';

String startedText = 'LET\'S GET STARTED';
String getInfoText = 'First, we need some basic information';
String registerText = 'REGISTER';
String bottomText = 'Already have an account? ';
String bottomHyperlink = ' Sign In';

class SignUpScreen extends StatefulWidget {
  static const String id = 'Sign Up Screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

void initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class _SignUpScreenState extends State<SignUpScreen> {
  String name = "";
  String surname = "";
  String email = "";
  String phoneNumber = "";
  String password = "";
  String passwordCheck = "";

  void setName(String input) {
    name = input;
  }

  void setSurname(String input) {
    surname = input;
  }

  void setEmail(String inputEmail) {
    email = inputEmail;
  }

  void setPhoneNumber(String input) {
    phoneNumber = input;
  }

  void setPassword(String inputPassword) {
    password = inputPassword;
  }

  void setPasswordCheck(String inputPassword) {
    passwordCheck = inputPassword;
  }

  void signUp() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: <Widget>[
          const Circles(),
          //text fields
          Center(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 120.0),

                  //started text
                  Text(startedText, style: kSignUpInScreen),
                  const SizedBox(height: 5.0),

                  //basic info
                  Text(getInfoText, style: kSignUpInfoStyle),
                  const SizedBox(height: 5.0),

                  //name
                  RegisterTextField(
                    hintText: 'Enter Your Name',
                    onChanged: setName,
                  ),

                  //surname
                  RegisterTextField(
                    hintText: 'Enter Your Surname',
                    onChanged: setSurname,
                  ),

                  //email
                  RegisterTextField(
                    hintText: 'Enter Your Email',
                    onChanged: setEmail,
                  ),

                  //phone number
                  RegisterTextField(
                    hintText: 'Enter Your Phone Number',
                    onChanged: setPhoneNumber,
                  ),

                  //choose password
                  RegisterTextField(
                    hintText: 'Choose a Password',
                    onChanged: setPassword,
                    obscured: true,
                  ),

                  //confirm password
                  RegisterTextField(
                    hintText: 'Confirm Your Password',
                    onChanged: setPasswordCheck,
                    obscured: true,
                  ),

                  //register button
                  RegisterButton(
                    title: registerText,
                    routeName: ContactOptionsScreen.id,
                    minWidth: 200.0,
                    height: 40.0,
                    pressedFunct: signUp,
                  ),

                  //bottom text
                  const Center(
                    child: BottomText(
                      bottomText: 'Already have an account?  ',
                      bottomHyperLink: 'Sign In',
                      routeName: SignInScreen.id,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
