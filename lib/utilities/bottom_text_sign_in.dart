import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:flutter/gestures.dart';

class BottomText extends StatelessWidget {
  const BottomText(
      {super.key,
      required this.bottomText,
      required this.bottomHyperLink,
      required this.page,
      this.toPop = false});

  final String bottomText;
  final String bottomHyperLink;
  final Widget page;
  final bool toPop;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          bottomText,
          style: kSignBottomTextStyle,
        ),
        Text.rich(
          TextSpan(
            style: kSignBottomTextRichStyle,
            children: [
              TextSpan(
                style: kSignBottomTextRichStyle,
                text: bottomHyperLink,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if (toPop) {
                      Navigator.pop(context);
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return page;
                      }));
                    }
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
