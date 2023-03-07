import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/firebase_utility.dart';

import '../utilities/register_text_field.dart';

class ChangeName extends StatelessWidget {
  String newName = "Unnamed";
  String newSurname = "Unnamed";
  void setName(String input) {
    newName = input;
  }

  void setSurname(String input) {
    newSurname = input;
  }

  @override
  Widget build(BuildContext context) {
    void clickedDone() {
      FirebaseUtility.updateName(newName);
      FirebaseUtility.updateSurname(newSurname);
      Navigator.pop(context);
      //TODO name is not updated in the settings page
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Change Name",
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
            hintText: "Enter new name: ",
            onChanged: setName,
            inputType: TextInputType.name,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          RegisterTextField(
            hintText: "Enter new surname: ",
            onChanged: setSurname,
            inputType: TextInputType.name,
            isLast: true,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Enter your new full name please. To cancel, press the back arrow.",
              style: kContactUtilitiesTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
