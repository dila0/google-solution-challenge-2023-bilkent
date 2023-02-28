import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';
import 'package:google_solution/utilities/register_text_field.dart';
import 'package:google_solution/utilities/register_button.dart';
import 'package:google_solution/screens/contact_options_screen.dart';
import 'package:google_solution/utilities/bottom_text_sign_in.dart';
import 'package:google_solution/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../utilities/snack_bar_utility.dart';

String startText = 'WELCOME BACK!';
String logInText = 'Log In';

class SignInScreen extends StatefulWidget {
  static const String id = 'Sign In Screen';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  bool showSpinner = false;

  void setEmail(String inputEmail) {
    email = inputEmail;
  }

  void setPassword(String inputPassword) {
    password = inputPassword;
  }

  void signIn() async {
    setState(() {
      showSpinner = true;
    });
    String errorMessage = "Login failed. Please try again.";
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      setState(() {
        showSpinner = false;
      });
      if (user != null) {
        Navigator.pushNamed(context, ContactOptionsScreen.id);
      }
    } on FirebaseAuthException catch (error) {
      print(error.code);
      print(error.message);
      switch (error.code) {
        //Taken from https://stackoverflow.com/questions/56113778/how-to-handle-firebase-auth-exceptions-on-flutter
        //Credit to Corentin Houdayer https://stackoverflow.com/users/6812501/corentin-houdayer
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          errorMessage = "Email already used. Go to login page.";
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          errorMessage = "Wrong email/password combination.";
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          errorMessage = "No user found with this email.";
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          errorMessage = "User disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          errorMessage = "Too many requests to log into this account.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          errorMessage = "Server error, please try again later.";
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          errorMessage = "Email address is invalid.";
          break;
        case "unknown":
          if (error.message == "Given String is empty or null") {
            errorMessage = "Please enter an Email and Password.";
          }
          break;
      }
      print(errorMessage);
    } catch (e) {
      print("FAILED*****************************");
      print(e);
    }

    SnackBarUtility.showFailureSnackBar(
        context, errorMessage, kGenericFailureSnackBarTitle, kButtonColor);
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
            child: Column(
              children: [
                const SizedBox(height: kSignUpScreenDistanceFromTop),

                //started text
                Text(startText, style: kSignUpInScreen),
                const SizedBox(height: 25.0),

                //image
                Image.asset(
                  'images/audio.png',
                  height: 300.0,
                ),

                const SizedBox(height: 15.0),
                //email
                RegisterTextField(
                  hintText: 'Enter Your Email',
                  onChanged: setEmail,
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: kSignUpScreenDistanceBetweenTextFields),

                //password
                RegisterTextField(
                  hintText: 'Enter Your Password',
                  onChanged: setPassword,
                  obscured: true,
                  inputType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 20.0),

                //register button
                RegisterButton(
                  title: logInText,
                  minWidth: 200.0,
                  height: 40.0,
                  pressedFunct: signIn,
                ),
                const SizedBox(height: 20.0),

                //bottom text
                const Center(
                  child: BottomText(
                    bottomText: 'Don\'t have an account?  ',
                    bottomHyperLink: 'Sign Up',
                    routeName: SignUpScreen.id,
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
