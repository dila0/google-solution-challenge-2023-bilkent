import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_solution/utilities/firebase_utility.dart';
import 'package:google_solution/utilities/snack_bar_utility.dart';
import 'constants.dart';
import 'custom_contact_picker.dart';

class EmergencyContactTextField extends StatefulWidget {
  EmergencyContactTextField(
      {super.key,
      required this.iconName,
      required this.startContact,
      required this.index,
      required this.deleteFunction,
      this.isLast = false});

  IconData iconName;
  Contact startContact;
  final bool isLast;
  int index;
  final Function deleteFunction;

  @override
  State<EmergencyContactTextField> createState() =>
      _EmergencyContactTextFieldState();
}

class _EmergencyContactTextFieldState extends State<EmergencyContactTextField> {
  @override
  Widget build(BuildContext context) {
    Contact currentContact = widget.startContact;
    Contact prevContact = widget.startContact;

    bool finished(Contact? c) {
      if (c == null || c.phoneNumber == "") {
        SnackBarUtility.showFailureSnackBar(
            context,
            "Select a contact with a phone number!",
            "Please select a valid contact");
        return false;
      }
      if (FirebaseUtility.contacts.contains(c.phoneNumber)) {
        SnackBarUtility.showFailureSnackBar(
            context,
            "A person with this phone number exists",
            "Please select a valid contact");
        widget.deleteFunction(widget.index);
        return false;
      } else if (FirebaseUtility.contactNames.contains(c.fullName)) {
        SnackBarUtility.showSystemFailureSnackBar(
            context, "A * has been added to contacts name.", "Name conflict");
        c.fullName = "*${c.fullName}";
      }
      if (c.fullName != "") {
        FirebaseUtility.addContact(c, prevContact);
        setState(() {
          widget.startContact = c;
          prevContact = widget.startContact;
        });
      }
      return true;
    }

    void delete(Contact input) {
      widget.deleteFunction(widget.index);
      if (input.fullName != "") {
        FirebaseUtility.removeContact(prevContact);
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.width * 0.01),
      color: Colors.white60,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(kButtonRoundness)),
        elevation: 1.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                currentContact.fullName ?? "-",
                style: kProfileNameTextStyle,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 1),
                  child: IconButton(
                    onPressed: () async {
                      Contact prev = widget.startContact;
                      print(prev.fullName);
                      Contact? c = await FlutterContactPicker.selectContact();
                      if (finished(c)) {
                        setState(() {
                          currentContact.fullName = c?.fullName ?? "";
                          currentContact.phoneNumber = c?.phoneNumber ?? "";
                        });
                      }
                    },
                    icon: Icon(widget.iconName),
                    iconSize: kBottomIconSize,
                    color: kCirclesColor,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 1),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        delete(currentContact);
                      });
                    },
                    icon: const Icon(Icons.delete_rounded),
                    iconSize: kBottomIconSize,
                    color: kCirclesColor,
                  ),
                ),
              ],
            ),
          ],

          //TODO: Take username
        ),
      ),
    );
  }
}
