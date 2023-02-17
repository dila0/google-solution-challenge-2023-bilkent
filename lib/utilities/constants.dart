import 'package:flutter/material.dart';

const kButtonColor = Color(0xFFEC368D);

const kBackgroundColor = Color(0xFFFCF0F0);

const kButtonRoundness = 10.0;

const kButtonTextStyle = TextStyle(
  fontFamily: 'Amatic SC' ,
  fontSize: 20.0,
  color: Colors.white,
);

const kWelcomeTextStyle = TextStyle(
  fontFamily: 'Oswald',
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

const kSignUpInScreen = TextStyle(
  fontFamily: 'Oswald',
  fontSize: 25.0,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const kSignUpInfoStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 17.0,
  fontWeight: FontWeight.normal,
  color: Colors.black45,
);

const kStartScreenBottomStyle = TextStyle(
  fontFamily: 'Oswald',
  fontSize: 20.0,
  fontWeight: FontWeight.normal,
  color: Colors.black38,
);

const kSignUpTextFieldTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w300,
  color: Colors.white24,
);

const kStartScreenButtonTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 17.0,
  color: Colors.white,
  fontWeight: FontWeight.w900,
);

const kStartScreenDistanceFromTop = 80.0;

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white60,
  hintText: 'Enter a value',

  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kButtonColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

