import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class ProfilePageContainer extends StatelessWidget {
  ProfilePageContainer({
    super.key,
    required this.iconName,
    this.profileNameString = "",
    this.userNameString = "",
  });

  Icon iconName;
  String profileNameString;
  String userNameString;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      color: Colors.white60,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(kButtonRoundness)),
        elevation: 1.0,
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                ],
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9.0),
                  child: Text(
                    "$userNameString   ",
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.ltr,
                    style: kProfileNameTextStyle,
                  ),
                ),
              ),
              //TODO: Take username
            ],
          ),
        ),
      ),
    );
  }
}
