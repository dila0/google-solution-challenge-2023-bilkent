import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';

class RegisterButton extends StatelessWidget {
   RegisterButton(
      {super.key,
      required this.height,
      required this.minWidth,
      required this.title,
      required this.pressedFunct, this.color});

  final String title;
  final double minWidth;
  final double height;
  final Function pressedFunct;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Material(
        color: (color == null) ? kButtonColor : color,
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
