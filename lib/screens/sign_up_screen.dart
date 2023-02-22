import 'package:flutter/material.dart';
import 'package:google_solution/screens/incoming_call_screen.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';

String startedText = 'LET\'S GET STARTED';
String getInfoText = 'First, we need some basic information';
String registerText = 'REGISTER';

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
          //top left corner circles
          Circles(),
          //text fields
          Center(
            child: Column(
              children: [
                SizedBox(height: 140.0),
                Text(
                  startedText,
                  style: kSignUpInScreen,
                ),
                SizedBox(
                  height: 5.0,
                ),
                //we need info text
                Text(
                  getInfoText,
                  style: kSignUpInfoStyle,
                ),
                SizedBox(
                  height: 35.0,
                ),
                //name
                SizedBox(
                  width: 350.0,
                  child: TextField(
                    style: kSignUpTextFieldTextStyle,
                    textAlign: TextAlign.left,
                    onChanged: (value) {
                      //TODO: on changed set state
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter Your Name'),
                  ),
                ),
                SizedBox(height: 20.0),
                //surname
                SizedBox(
                  width: 350.0,
                  child: TextField(
                    style: kSignUpTextFieldTextStyle,
                    textAlign: TextAlign.left,
                    onChanged: (value) {
                      //TODO: on changed set state
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter Your Surname'),
                  ),
                ),
                SizedBox(height: 20.0),
                //email
                SizedBox(
                  width: 350.0,
                  child: TextField(
                    style: kSignUpTextFieldTextStyle,
                    textAlign: TextAlign.left,
                    onChanged: (value) {
                      //TODO: on changed set state
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter Your Email'),
                  ),
                ),
                SizedBox(height: 20.0),
                //phone number
                SizedBox(
                  width: 350.0,
                  child: TextField(
                    style: kSignUpTextFieldTextStyle,
                    textAlign: TextAlign.left,
                    onChanged: (value) {
                      //TODO: on changed set state
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter Your Phone Number'),
                  ),
                ),
                SizedBox(height: 20.0),
                //password
                SizedBox(
                  width: 350.0,
                  child: TextField(
                    style: kSignUpTextFieldTextStyle,
                    textAlign: TextAlign.left,
                    onChanged: (value) {
                      //TODO: on changed set state
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Choose a Password'),
                  ),
                ),
                SizedBox(height: 20.0),
                //confirm password
                SizedBox(
                  width:350.0,
                  child: TextField(
                    style: kSignUpTextFieldTextStyle,
                    textAlign: TextAlign.left,
                    onChanged: (value) {
                      //TODO: on changed set state
                    },
                    decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Confirm Your Password'),
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.fromLTRB(142.0,0,0,0),
                  child: Material(
                    color: kButtonColor,
                    borderRadius: BorderRadius.all(Radius.circular(kButtonRoundness)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: (){
                        Navigator.pushNamed(context, IncomingScreen.id);
                      },
                      minWidth: 200.0,
                      height: 40.0,
                      child: Text(
                        registerText,
                        style: kStartScreenButtonTextStyle,
                      ),
                    ),
                  ),
                ),
                Text('data'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}