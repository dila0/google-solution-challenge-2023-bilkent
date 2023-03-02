import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';


class ProfilePageContainer extends StatelessWidget {
  ProfilePageContainer({super.key,
    required this.iconName,
    required this.profileNameString,
    required this.userNameString,
    required this.widthBetween,
  });

  Icon iconName;
  String profileNameString;
  String userNameString;
  double widthBetween;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
      color: Colors.white60,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(kButtonRoundness)),
        elevation: 1.0,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: iconName,
              iconSize: kBottomIconSize,
              color: kCirclesColor,
            ),
            Text(
              profileNameString,
              style: kProfileNameTextStyle,
            ),
            SizedBox(width: widthBetween,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.13,
            ),
            Text(
              userNameString,
              textAlign: TextAlign.right,
              textDirection: TextDirection.ltr,
              style: kProfileNameTextStyle,
            ),
            //TODO: Take username
          ],
        ),
      ),
    );
  }
}