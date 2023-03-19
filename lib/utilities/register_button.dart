import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton(
      {super.key,
      required this.height,
      required this.minWidth,
      required this.title,
      required this.pressedFunct});

  final String title;
  final double minWidth;
  final double height;
  final Function pressedFunct;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Material(
        color: kButtonColor,
        borderRadius: const BorderRadius.all(Radius.circular(kButtonRoundness)),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: () async {
            await pressedFunct();
          },
          minWidth: minWidth,
          height: height,
          child: Text(
            title,
            style: kStartScreenButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
