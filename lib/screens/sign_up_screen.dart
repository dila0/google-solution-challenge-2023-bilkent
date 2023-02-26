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
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  //credentials
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

  void signUp() async {
    setState(() {
      showSpinner = true;
    });

    //TODO do something if passwords dont match

    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("up to here******************");
      await _auth.currentUser?.updateDisplayName("$name $surname");
//TODO does this work really?
      //TODO if failed do SOMETHING
      setState(() {
        showSpinner = false;
      });
      print("user signed up***************************");
      String? dispName = (await _auth.currentUser?.displayName);
      print(dispName);
    } catch (e) {
      //TODO if exception is about bad password do SOMETHING
      print("FAILED*****************************");
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

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
                    inputType: TextInputType.name,
                  ),

                  //surname
                  RegisterTextField(
                    hintText: 'Enter Your Surname',
                    onChanged: setSurname,
                    inputType: TextInputType.name,
                  ),

                  //email
                  RegisterTextField(
                    hintText: 'Enter Your Email',
                    onChanged: setEmail,
                    inputType: TextInputType.emailAddress,
                  ),

                  //phone number
                  RegisterTextField(
                    hintText: 'Enter Your Phone Number',
                    onChanged: setPhoneNumber,
                    inputType: TextInputType.phone,
                  ),

                  //choose password
                  RegisterTextField(
                    hintText: 'Choose a Password',
                    onChanged: setPassword,
                    obscured: true,
                    inputType: TextInputType.visiblePassword,
                  ),

                  //confirm password
                  RegisterTextField(
                    hintText: 'Confirm Your Password',
                    onChanged: setPasswordCheck,
                    obscured: true,
                    inputType: TextInputType.visiblePassword,
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
