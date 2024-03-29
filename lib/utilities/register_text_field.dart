import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';

class RegisterTextField extends StatelessWidget {
   RegisterTextField(
      {super.key,
      required this.hintText,
      required this.onChanged,
      this.obscured = false,
      this.inputType = TextInputType.text,
      this.isLast = false});
  final bool obscured;
  final String hintText;
  final Function onChanged;
  final TextInputType inputType;
  final bool isLast;

  @override

  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.height / 2),
      child: TextField(
        enabled: true,

        style: kSignUpTextFieldTextStyle,
        textAlign: TextAlign.left,
        onChanged: (value) {
          onChanged(value);
        },
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        obscureText: obscured,
        decoration: kTextFieldDecoration.copyWith(hintText: hintText),
        keyboardType: inputType,
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
      ),
    );
  }
}
