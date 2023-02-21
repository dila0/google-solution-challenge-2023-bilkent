import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';
import 'package:google_solution/utilities/register_button.dart';
import 'package:google_solution/utilities/register_text_field.dart';
import 'package:google_solution/utilities/bottom_text_sign_in.dart';
import 'sign_in_screen.dart';
import 'contact_options_screen.dart';

String startedText = 'LET\'S GET STARTED';
String getInfoText = 'First, we need some basic information';
String registerText = 'REGISTER';
String bottomText = 'Already have an account? ';
String bottomHyperlink = ' Sign In';

class SignUpScreen extends StatefulWidget{
  static const String id = 'Sign Up Screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: <Widget>[
          const Circles(),
          //text fields
          Center(
            child: Column(
              children: [
                const SizedBox(height: 140.0),

                //started text
                Text(startedText, style: kSignUpInScreen),
                const SizedBox(height: 5.0),

                //basic info
                Text(getInfoText, style: kSignUpInfoStyle),
                const SizedBox(height: 35.0),

                //name
                const RegisterTextField(hintText: 'Enter Your Name'),
                const SizedBox(height: kSignUpScreenDistanceBetweenTextFields),

                //surname
                const RegisterTextField(hintText: 'Enter Your Surname'),
                const SizedBox(height: kSignUpScreenDistanceBetweenTextFields),

                //email
                const RegisterTextField(hintText: 'Enter Your Email'),
                const SizedBox(height: kSignUpScreenDistanceBetweenTextFields),

                //phone number
                const RegisterTextField(hintText: 'Enter Your Phone Number'),
                const SizedBox(height: kSignUpScreenDistanceBetweenTextFields),

                //choose password
                const RegisterTextField(hintText: 'Choose a Password'),
                const SizedBox(height: kSignUpScreenDistanceBetweenTextFields),

                //confirm password
                const RegisterTextField(hintText: 'Confirm Your Password'),
                const SizedBox(height: kSignUpScreenDistanceBetweenTextFields),

                //register button
                RegisterButton(title: registerText, routeName: ContactOptionsScreen.id, minWidth: 200.0, height: 40.0),
                const SizedBox(height: 20.0),

                //bottom text
                const Center(
                  child: BottomText(
                    bottomText: 'Already have an account?  ',
                    bottomHyperLink: 'Sign In',
                    routeName: SignInScreen.id,
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


