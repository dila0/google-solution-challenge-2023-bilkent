import 'package:flutter/material.dart';

const kButtonColor = Color(0xFFF5547F);

const kCirclesColor = Color(0xFFEE96B8);
const kContactColor = Color(0xFFF0B6CB);
const kBackgroundColor = Color(0xFFFCEEF7);
const kBottomAppBarColor = Color(0XFFFFD7FC);
const kCallBackgroundColor = Color(0xFF1A2319);

const kMessage = "I am in danger!";

const kButtonRoundness = 10.0;

const kCallContainerColor = Color(0xBF070907);

const kCallButtonColor = Color(0x4F070900);

const kCallerIdTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 40.0,
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

const kInfoTileStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);
const kInfoTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  color: Colors.black87,
);
const kButtonTextStyle = TextStyle(
  fontFamily: 'Amatic SC',
  fontSize: 20.0,
  color: Colors.white,
);

const kWelcomeTextStyle = TextStyle(
  fontFamily: 'Oswald',
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

const kIntroDescriptionStyle = TextStyle(
  fontFamily: 'Amatic SC',
  fontSize: 23.0,
  fontWeight: FontWeight.w300,
  color: Colors.black,
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
  color: Colors.black45,
);

const kStartScreenButtonTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 17.0,
  color: Colors.white,
  fontWeight: FontWeight.w900,
);

const kSignBottomTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 12.0,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

const kSignBottomTextRichStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 12.0,
  color: kButtonColor,
  fontWeight: FontWeight.w500,
);

const kStartScreenDistanceFromTop = 80.0;
const kSignUpScreenDistanceBetweenTextFields = 20.0;
const kSignUpScreenDistanceFromTop = 70.0;
const kBottomIconSize = 40.0;
const kBottomIconDistance = 50.0;

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
const kContactNameTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 20.0,
  shadows: [
    Shadow(
      color: Colors.black87,
      offset: Offset(0, -3),
    )
  ],
  fontWeight: FontWeight.w900,
  decorationColor: Colors.black,
  color: Colors.transparent,
  decorationThickness: 2,
  decoration: TextDecoration.underline,
);

const kContactDurationTextStyle = TextStyle(
  shadows: [
    Shadow(
      color: Colors.black45,
      offset: Offset(0, -3),
    ),
  ],
  decorationColor: Colors.black45,
  color: Colors.transparent,
  fontFamily: 'Poppins',
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  decoration: TextDecoration.underline,
  decorationStyle: TextDecorationStyle.solid,
);

const kContactUtilitiesTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 14.0,
  fontWeight: FontWeight.w700,
  color: Colors.black54,
);

const String kGenericFailureSnackBarTitle = '  Looks like there is a mistake!';

const kSavedAudioTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 30.0,
  color: Colors.white,
  fontWeight: FontWeight.w900,
);

const kWarningTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 13.0,
  color: Colors.black87,
  fontWeight: FontWeight.w500,
);

const kEmergencyContactTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 17.0,
  fontWeight: FontWeight.w900,
  color: Colors.black54,
);

const kProfileNameTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

const kEditTextStyle = TextStyle(
  fontFamily: 'Poppins',
  color: Colors.black,
  decoration: TextDecoration.underline,
  fontSize: 13.0,
  fontWeight: FontWeight.w500,
);
const kProfileButton = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 14.0,
  fontWeight: FontWeight.w700,
  color: Colors.black54,
  decoration: TextDecoration.underline,
  decorationStyle: TextDecorationStyle.solid,
);

const kProfilePopUpStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 17.0,
  shadows: [
    Shadow(
      color: Colors.black87,
      offset: Offset(0, -3),
    )
  ],
  fontWeight: FontWeight.w900,
  decorationColor: Colors.black,
  color: Colors.transparent,
);
