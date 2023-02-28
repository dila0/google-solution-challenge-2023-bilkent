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
import 'package:google_solution/utilities/snack_bar_utility.dart';

String startedText = 'LET\'S GET STARTED';
String getInfoText = 'First, we need some basic information';
String registerText = 'REGISTER';
String bottomText = 'Already have an account? ';
String bottomHyperlink = ' Sign In';
bool isDebug = true; //TODO remove before release, used to skip sign up screen

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
    if (isDebug) {
      //TODO remove before release
      Navigator.pushNamed(context, ContactOptionsScreen.id);
    }
    setState(() {
      showSpinner = true;
    });
    if (password != passwordCheck) {
      SnackBarUtility.showFailureSnackBar(context, 'Passwords does not match!',
          kGenericFailureSnackBarTitle, kButtonColor);
      return;
    }

    String errorMessage = "Login failed. Please try again.";

    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password); //create the user
      await _auth.currentUser?.updateDisplayName("$name $surname");
      //TODO link phone number
      setState(() {
        showSpinner = false; //TODO add spinner
      });
      Navigator.pushNamed(context, ContactOptionsScreen.id);

      String? dispName =
          (await _auth.currentUser?.displayName); //Update the display name

      return; //to avoid snackbar if everything is fine
    } on FirebaseAuthException catch (error) {
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
    } catch (e) {
      print("FAILED TO REGISTER*****************************");
      print(e);
    }
    SnackBarUtility.showFailureSnackBar(
        context, errorMessage, kGenericFailureSnackBarTitle, kButtonColor);
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
                    hintText: '*Enter Your Email',
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
                    hintText: '*Choose a Password',
                    onChanged: setPassword,
                    obscured: true,
                    inputType: TextInputType.visiblePassword,
                  ),

                  //confirm password
                  RegisterTextField(
                    hintText: '*Confirm Your Password',
                    onChanged: setPasswordCheck,
                    obscured: true,
                    inputType: TextInputType.visiblePassword,
                  ),

                  //register button
                  RegisterButton(
                    title: registerText,
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
