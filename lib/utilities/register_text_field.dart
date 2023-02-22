import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';

class RegisterTextField extends StatelessWidget {

  const RegisterTextField({super.key, required this.hintText});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.0,
      child: TextField(
        style: kSignUpTextFieldTextStyle,
        textAlign: TextAlign.left,
        onChanged: (value) {
          //TODO: on changed set state
        },
        decoration:
        kTextFieldDecoration.copyWith(hintText: hintText),
      ),
    );
  }
}
