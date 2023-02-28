import 'package:flutter/material.dart';

String circleImage = 'images/circles.png';

class Circles extends StatelessWidget {
  const Circles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topLeft,
          image: AssetImage(circleImage),
        ),
      ),
    );
  }
}
