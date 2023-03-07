import 'package:flutter/material.dart';
import 'package:google_solution/screens/add_emergency_contacts_screen.dart';
import 'package:google_solution/utilities/custom_animations.dart';
import 'package:google_solution/utilities/firebase_utility.dart';
import 'constants.dart';

class EmergencyContactContainer extends StatelessWidget {
  const EmergencyContactContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(kButtonRoundness)),
        onTap: () {
          Navigator.push(context,
              CustomAnimations.slideTransition(page: AddEmergencyContact()));
        },
        child: Container(
          color: Colors.white60,
          child: Material(
            borderRadius:
                const BorderRadius.all(Radius.circular(kButtonRoundness)),
            elevation: 1.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.phone,
                  size: kBottomIconSize,
                  color: kCirclesColor,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width * 0.05),
                  child: const Text(
                    'ADD EMERGENCY CONTACTS',
                    style: kEmergencyContactTextStyle,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: kBottomIconSize,
                  color: kCirclesColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
