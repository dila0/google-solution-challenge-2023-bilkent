import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import '../utilities/firebase_utility.dart';
import '../utilities/register_text_field.dart';

class ChangePassword extends StatelessWidget {
  String newPassword = "";
  String newPasswordCheck = "";

  void setNewPassword(String input) {
    newPassword = input;
  }

  void setNewPasswordCheck(String input) {
    newPasswordCheck = input;
  }

  @override
  Widget build(BuildContext context) {
    void clickedDone() {
      bool success = FirebaseUtility.updatePassword(
          context, newPassword, newPasswordCheck);
      if (success) {
        Navigator.pop(context);
      }
      //TODO name is not updated in the settings page
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Change Password",
          style: kEmergencyContactTextStyle.copyWith(color: Colors.black87),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: kButtonColor,
          ),
        ),
        actions: [
          TextButton(
              onPressed: clickedDone,
              child: Text("Done",
                  style:
                      kEmergencyContactTextStyle.copyWith(color: kButtonColor)))
        ],
      ),
      backgroundColor: kBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
            width: double.infinity,
          ),
          RegisterTextField(
            hintText: "Enter new password: ",
            onChanged: setNewPassword,
            inputType: TextInputType.name,
            obscured: true,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          RegisterTextField(
            hintText: "Confirm new password: ",
            onChanged: setNewPasswordCheck,
            inputType: TextInputType.name,
            isLast: true,
            obscured: true,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Enter your new password please. Bear in mind that the new password should at least be 6 characters. To cancel, press the back arrow.",
              style: kContactUtilitiesTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
