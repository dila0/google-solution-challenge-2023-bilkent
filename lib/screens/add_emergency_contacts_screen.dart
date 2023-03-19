import 'package:flutter/material.dart';
import 'package:google_solution/utilities/emergency_contact_textfield.dart';
import 'package:google_solution/utilities/firebase_utility.dart';
import '../utilities/constants.dart';
import '../utilities/custom_contact_picker.dart';

class AddEmergencyContact extends StatefulWidget {
  const AddEmergencyContact({Key? key}) : super(key: key);

  @override
  State<AddEmergencyContact> createState() => _AddEmergencyContactState();
}

class _AddEmergencyContactState extends State<AddEmergencyContact> {
  List<EmergencyContactTextField> containers = [];

  void deleteFunc(int index) {
    setState(() {
      containers.removeAt(index);
      for (int i = index; i < containers.length; i++) {
        containers[i].index--;
      }
    });
  }

  void initContainers() {
    containers = [];
    for (int i = 0; i < FirebaseUtility.contacts.length; i++) {
      final Contact c = Contact();
      c.phoneNumber = FirebaseUtility.contacts[i];
      c.fullName = FirebaseUtility.contactNames[i];
      containers.add(
        EmergencyContactTextField(
          iconName: Icons.edit,
          startContact: c,
          index: i,
          deleteFunction: deleteFunc,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    initContainers();
  }

  @override
  Widget build(BuildContext context) {
    void addEmptyContact() {
      setState(() {
        containers.add(EmergencyContactTextField(
          iconName: Icons.edit,
          startContact: Contact(fullName: "", phoneNumbers: []),
          index: containers.length,
          deleteFunction: deleteFunc,
        ));
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Edit Emergency Contacts",
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
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
              width: double.infinity,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: containers.map((e) {
                return e;
              }).toList(),
            ),
            IconButton(
              onPressed: () {
                addEmptyContact();
              },
              icon: const Icon(Icons.add),
              iconSize: kBottomIconSize,
              color: kCirclesColor,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "To add a new emergency contact please click + and enter their phone number. \n \nEmpty contacts will not be saved! ",
                style: kContactUtilitiesTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
