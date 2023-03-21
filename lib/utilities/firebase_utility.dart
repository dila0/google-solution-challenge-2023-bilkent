import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_solution/utilities/custom_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/start_screen.dart';
import 'constants.dart';
import 'custom_contact_picker.dart';
import 'snack_bar_utility.dart';

class FirebaseUtility {
  //static class since there can only be one user per app
  //using static allows us to not create an instance of the class for each use
  static final _fireStore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;
  static const logOutTitle = 'Logged out';
  static const logOutMessage = 'Successfully logged out from the app';
  static const changePasswordTitle = 'Password Changed!';
  static const changePasswordMessage = 'Successfully changed the password';
  static const logOutFailTitle = 'Log out failed!';
  static const failMessage = 'Failed due to a system error';
  static const deleteTitle = 'Account deleted';
  static const deleteMessage = 'Successfully deleted your account and data';
  static const systemFailTitle = 'Failed!';
  static const deleteFailMessage =
      'Failed to delete your account due to a system error';
  static String name = "";
  static String surname = "";
  static String phoneNumber = "";
  static String customMessage = kMessage;
  static List<String> contacts = [];
  static List<String> contactNames = [];
  static Set<String> favourites = {};
  static Color myColor = kButtonColor;
  static late SharedPreferences prefs;

  ///read from database and update local static variables
  static Future<bool> refresh() async {
    final docRef = await _fireStore
        .collection("users")
        .doc(_auth.currentUser?.uid)
        .get()
        .then((ds) async {
      await insertData(ds);
    });
    await getPreferences();

    return false;
  }

  static Future<void> getPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> insertData(ds) async {
    name = ds.data()!['name'];
    surname = ds.data()!['surname'];
    phoneNumber = ds.data()!['phone'];
    customMessage = ds.data()!['message'];
    //Below try check is to check if retrieved data is Null
    //for some reason if else does not work
    try {
      favourites = Set<String>.from(ds.data()!['favourites']);
    } catch (error) {
      favourites = {};
    }
    try {
      contacts = List<String>.from(ds.data()!['emergencyContacts']);
      contactNames = List<String>.from(ds.data()!['contactNames']);
    } catch (error) {
      contacts = [];
      contactNames = [];
    }
    int colorString = (ds.data()['color'] ?? kButtonColor.value);
    double opacity = (ds.data()['colorOpacity'] ?? 1.0).toDouble();
    myColor = Color(colorString).withOpacity(opacity);
    return true;
  }

  /// Sets local static variables
  /// Used for sign up
  static void setUserData(
      {required name, required surname, required phoneNumber, customMessage}) {
    FirebaseUtility.name = name;
    FirebaseUtility.surname = surname;
    FirebaseUtility.phoneNumber = phoneNumber;
    FirebaseUtility.customMessage = customMessage ?? kMessage;
  }

  /// Saves every local static variable in this class to database
  static void saveUserData() {
    _fireStore.collection('users').doc(_auth.currentUser?.uid).set({
      'name': name,
      'surname': surname,
      'phone': phoneNumber,
      'message': customMessage,
      'emergencyContacts': contacts,
      'favourites': favourites,
      'contactNames': contactNames,
      'color': myColor.value,
      'colorOpacity': myColor.opacity
    }).catchError((error) => {print(error)});

    //TODO handle error
  }

  static void addFavourite(String favourite) {
    favourites.add(favourite);
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'favourites': favourites}).catchError(
            (error) => {print(error)}); //TODO handle error
  }

  static void removeFavourite(String favourite) {
    favourites.remove(favourite);
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'favourites': favourites}).catchError(
            (error) => {print(error)}); //TODO handle error
  }

  static void addContact(Contact contact, Contact oldContact) {
    contacts.remove(oldContact.phoneNumber);
    contacts.add(contact.phoneNumber);
    contactNames.remove(oldContact.fullName);
    contactNames.add(contact.fullName);

    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'emergencyContacts': contacts}).catchError(
            (error) => {print(error)}); //TODO handle error

    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'contactNames': contactNames}).catchError(
            (error) => {print(error)}); //TODO handle error
  }

  static void removeContact(Contact contact) {
    contacts.remove(contact.phoneNumber);
    contactNames.remove(contact.fullName);
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'emergencyContacts': contacts}).catchError(
            (error) => {print(error)}); //TODO handle error
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'contactNames': contactNames}).catchError(
            (error) => {print(error)}); //TODO handle error
  }

  /// All functions below updates their respective fields in the database
  /// Writing local static variables to database
  static void updateContacts(List<String> contacts, List<String> contactNames) {
    FirebaseUtility.contacts = contacts;
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'emergencyContacts': contacts}).catchError(
            (error) => {print(error)}); //TODO handle error

    FirebaseUtility.contactNames = contactNames;
    _fireStore.collection('users').doc(_auth.currentUser?.uid).update(
        {'contactNames': contactNames}).catchError((error) => {print(error)});
  }

  static void updateColor(Color color) {
    FirebaseUtility.myColor = color;
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'color': color.value}).catchError(
            (error) => {print(error)}); //TODO handle error
    _fireStore.collection('users').doc(_auth.currentUser?.uid).update(
        {'colorOpacity': color.opacity}).catchError((error) => {print(error)});
  }

  static void updateName(String name) {
    FirebaseUtility.name = name;
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'name': name}).catchError(
            (error) => {print(error)}); //TODO handle error
  }

  static void updateSurname(String surname) {
    FirebaseUtility.surname = surname;
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'surname': surname}).catchError(
            (error) => {print(error)}); //TODO handle error
  }

  static void updateCustomMessage(String message, BuildContext context) {
    if (message == FirebaseUtility.customMessage) {
      return;
    }
    if (message == "") {
      SnackBarUtility.showFailureSnackBar(
          context,
          "Emergency message cannot be empty",
          "Please enter a valid emergency message");
    }
    FirebaseUtility.customMessage = message;
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'message': message}).catchError(
            (error) => {print(error)}); //TODO handle error
  }

  static void updatePhone(String phone) {
    FirebaseUtility.phoneNumber = phone;
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'phone': phone}).catchError(
            (error) => {print(error)}); //TODO handle error
  }

  static void updateFavourites(Set<String> favouritesByName) {
    FirebaseUtility.favourites = favouritesByName;
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'favourites': favouritesByName}).catchError(
            (error) => {print(error)}); //TODO handle error
  }

  static void reset() {
    name = "";
    surname = "";
    phoneNumber = "";
    customMessage = kMessage;
    contacts = [];
    favourites = {};
    myColor = kButtonColor;
    contactNames = [];
  }

  static void logout(BuildContext context) {
    if (_auth.currentUser != null) {
      _auth
          .signOut()
          .then((value) => {
                SnackBarUtility.showSuccessSnackBar(
                    context, logOutMessage, logOutTitle)
              })
          .catchError((error) => {
                SnackBarUtility.showSystemFailureSnackBar(
                    context, failMessage, logOutFailTitle)
              });
    }
    reset();
    Navigator.pushAndRemoveUntil(
        context,
        CustomAnimations.slideTransition(page: StartScreen()),
        (route) => false); //In any case Navigate back to start page
  }

  static void deleteAccount(BuildContext context) {
    if (_auth.currentUser != null) {
      _fireStore.collection('users').doc(_auth.currentUser?.uid).delete();
      _auth.currentUser
          ?.delete()
          .then((value) => {
                SnackBarUtility.showSuccessSnackBar(
                    context, deleteMessage, deleteTitle)
              })
          .catchError((error) => {
                SnackBarUtility.showSystemFailureSnackBar(
                    context, deleteFailMessage, systemFailTitle)
              });
    }
    reset();
    Navigator.pushAndRemoveUntil(
        context,
        CustomAnimations.slideTransition(page: StartScreen()),
        (route) => false); //In any case Navigate back to start page
  }

  static bool updatePassword(
      BuildContext context, String newPassword, String newPasswordCheck) {
    if (newPassword != newPasswordCheck) {
      SnackBarUtility.showFailureSnackBar(
          context, 'Passwords does not match!', kGenericFailureSnackBarTitle);
      return false;
    }
    if (newPassword.length < 6) {
      SnackBarUtility.showFailureSnackBar(
          context,
          'Password should be longer than 6 characters!',
          kGenericFailureSnackBarTitle);
      return false;
    }
    if (_auth.currentUser != null) {
      _auth.currentUser
          ?.updatePassword(newPassword)
          .then((value) => {
                SnackBarUtility.showSuccessSnackBar(
                    context, changePasswordMessage, changePasswordTitle)
              })
          .catchError((error) => {
                SnackBarUtility.showSystemFailureSnackBar(
                    context, failMessage, systemFailTitle)
              });
    }
    return true; //TODO what if no user? is it even possible?
    //TODO success message for SOME reason never shows (even when it in fact is successful)
  }
}
