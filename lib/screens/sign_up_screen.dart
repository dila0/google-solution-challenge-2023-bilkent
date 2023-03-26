import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_solution/screens/main_screen.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';
import 'package:google_solution/utilities/hero_dialog_route.dart';
import 'package:google_solution/utilities/register_button.dart';
import 'package:google_solution/utilities/register_text_field.dart';
import 'package:google_solution/utilities/bottom_text_sign_in.dart';
import 'package:google_solution/utilities/terms_conditions.dart';
import '../utilities/custom_animations.dart';
import '../utilities/custom_rect_tween.dart';
import 'sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_solution/utilities/snack_bar_utility.dart';
import 'package:google_solution/utilities/firebase_utility.dart';
import 'package:url_launcher/url_launcher.dart';

String startedText = 'LET\'S GET STARTED';
String getInfoText = 'First, we need some basic information';
String registerText = 'REGISTER';
String bottomText = 'Already have an account? ';
String bottomHyperlink = ' Sign In';
bool isDebug = false; //TODO remove before release, used to skip sign up screen

class SignUpScreen extends StatefulWidget {
  static const String id = 'Sign Up Screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
  const SignUpScreen({super.key});
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
  bool termsChecked = false;
  bool termsRead = false;

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
      //TODO remove
      Navigator.pushNamed(context, MainPage.id);
    }
    setState(() {
      showSpinner = true;
    });
    if (password != passwordCheck) {
      SnackBarUtility.showFailureSnackBar(
          context, 'Passwords does not match!', kGenericFailureSnackBarTitle);
      return;
    }
    if (!termsChecked) {
      SnackBarUtility.showFailureSnackBar(
        context,
        'It only includes standard procedures',
        'Please accept terms & conditions',
      );
      return;
    }

    String errorMessage = "Login failed. Please try again.";
    bool isSuccess = true;
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password); //create the user
      await _auth.currentUser?.updateDisplayName("$name $surname");

      setState(() {
        showSpinner = false; //TODO add spinner
      });

      //Update the display name
      String? dispName = (await _auth.currentUser?.displayName);

      //If everything is fine write to database
      FirebaseUtility.setUserData(
          name: name,
          surname: surname,
          phoneNumber: phoneNumber,
          customMessage: kMessage); //update the local static variables
       FirebaseUtility.saveUserData(); //write to database
      await FirebaseUtility.getPreferences();
      Navigator.pushAndRemoveUntil(context,
          CustomAnimations.slideTransition(page: MainPage()), (route) => false);
    } on FirebaseAuthException catch (error) {
      isSuccess = false;
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
    if (isSuccess) {
      Navigator.pushNamed(context, MainPage.id);
    } else {
      SnackBarUtility.showFailureSnackBar(
          context, errorMessage, kGenericFailureSnackBarTitle);
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
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            const Circles(),
            //text fields
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 9,
                  ),

                  //started text
                  Text(startedText, style: kSignUpInScreen),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),

                  //basic info
                  Text(getInfoText, style: kSignUpInfoStyle),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),

                  //name
                  RegisterTextField(
                    hintText: 'Enter Your Name',
                    onChanged: setName,
                    inputType: TextInputType.name,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  //surname
                  RegisterTextField(
                    hintText: 'Enter Your Surname',
                    onChanged: setSurname,
                    inputType: TextInputType.name,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  //email
                  RegisterTextField(
                    hintText: '*Enter Your Email',
                    onChanged: setEmail,
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  //phone number
                  RegisterTextField(
                    hintText: 'Enter Your Phone Number',
                    onChanged: setPhoneNumber,
                    inputType: TextInputType.phone,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  //choose password
                  RegisterTextField(
                    hintText: '*Choose a Password',
                    onChanged: setPassword,
                    obscured: true,
                    inputType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  //confirm password
                  RegisterTextField(
                      hintText: '*Confirm Your Password',
                      onChanged: setPasswordCheck,
                      obscured: true,
                      inputType: TextInputType.visiblePassword,
                      isLast: true),
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.height / 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: termsChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                termsChecked = value!;
                              });
                              if (!termsRead) {
                                Navigator.of(context).push(HeroDialogRoute(
                                    builder: (context) {
                                      return _AddTodoPopupCard();
                                    },
                                    settings: const RouteSettings()));
                              }
                              termsRead = true;
                            }),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(HeroDialogRoute(
                                builder: (context) {
                                  return _AddTodoPopupCard();
                                },
                                settings: const RouteSettings()));
                            termsRead = true;
                          },
                          child: const Hero(
                            tag: _heroAddTodo,
f                            child: Text(
                              "Terms & Conditions",
                                style: kSignBottomTextRichStyle,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //register button
                  RegisterButton(
                    title: registerText,
                    minWidth: MediaQuery.of(context).size.height / 3,
                    height: MediaQuery.of(context).size.height / 22,
                    pressedFunct: signUp,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
                  //bottom text
                  const Center(
                    child: BottomText(
                      bottomText: 'Already have an account?  ',
                      bottomHyperLink: 'Sign In',
                      page: SignInScreen(),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 85),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const String _heroAddTodo = 'add-todo-hero';

class _AddTodoPopupCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 20),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: kBackgroundColor,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height / 25)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 200),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.fast),
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 30),
                  child: Text.rich(TextSpan(
                    children: [
                  const TextSpan(text: kTermsConditions),
                  TextSpan(
                    text: '\t\t\t\t●\tGoogle Play Services\n',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(
                            Uri.parse('https://policies.google.com/terms'));
                      },
                  ),
                  TextSpan(
                    text: '\t\t\t\t●\tGoogle Analytics for Firebase\n',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(Uri.parse(
                            'https://firebase.google.com/terms/analytics'));
                      },
                  ),
                  TextSpan(
                    text: '\t\t\t\t●\tFirebase Crashlytics\n',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl(Uri.parse(
                            'https://firebase.google.com/terms/crashlytics'));
                      },
                  ),
                  const TextSpan(text: kTermsConditions2),
                    ],
                  )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
