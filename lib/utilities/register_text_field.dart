import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';

class RegisterTextField extends StatelessWidget {
  const RegisterTextField(
      {super.key, required this.hintText, required this.onChanged});

  final String hintText;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.0,
      child: TextField(
        style: kSignUpTextFieldTextStyle,
        textAlign: TextAlign.left,
        onChanged: (value) {
          onChanged(value);
        },
        decoration: kTextFieldDecoration.copyWith(hintText: hintText),
      ),
    );
  }
}
