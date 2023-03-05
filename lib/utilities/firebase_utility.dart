import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../screens/start_screen.dart';
import 'snack_bar_utility.dart';

class FirebaseUtility {
  //static class since there can only be one user per app
  //using static allows us to not create an instance of the class for each use
  static final _fireStore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;
  static const logOutTitle = 'Logged out';
  static const logOutMessage = 'Successfully logged out from the app';
  static const logOutFailTitle = 'Log out failed!';
  static const logOutFailMessage = 'Failed to log out due to a system error';
  static String name = "";
  static String surname = "";
  static String phoneNumber = "";
  static List<String> contacts = [];
  static List<String> favourites = [];

  ///read from database and update local static variables
  static Future<bool> refresh() async {
    final docRef = await _fireStore
        .collection("users")
        .doc(_auth.currentUser?.uid)
        .get()
        .then((ds) {
      name = ds.data()!['name'];
      surname = ds.data()!['surname'];
      phoneNumber = ds.data()!['phone'];
      //TODO adding favourites and contacts results in an error but should be done
    });
    return false;
  }

  /// Sets local static variables
  static void setUserData(
      {required name, required surname, required phoneNumber}) {
    FirebaseUtility.name = name;
    FirebaseUtility.surname = surname;
    FirebaseUtility.phoneNumber = phoneNumber;
  }

  /// Saves every local static variable in this class to database
  static void saveUserData() {
    _fireStore.collection('users').doc(_auth.currentUser?.uid).set({
      'name': name,
      'surname': surname,
      'phone': phoneNumber,
      'emergencyContacts': contacts,
      'favourites': favourites
    }).catchError((error) => {print(error)});

    //TODO handle error
  }

  /// All functions below updates their respective fields in the database
  /// Writing local static variables to database
  static void updateContacts(List<String> contacts) {
    FirebaseUtility.contacts = contacts;
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'emergencyContacts': contacts}).catchError(
            (error) => {print(error)}); //TODO handle error
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

  static void updatePhone(String phone) {
    FirebaseUtility.phoneNumber = phone;
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'phone': phone}).catchError(
            (error) => {print(error)}); //TODO handle error
  }

  static void updateFavourites(List<String> favouritesByName) {
    FirebaseUtility.favourites = favouritesByName;
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'favourites': favouritesByName}).catchError(
            (error) => {print(error)}); //TODO handle error
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
                    context, logOutFailMessage, logOutFailTitle)
              });
    }
    Navigator.pushNamedAndRemoveUntil(context, StartScreen.id,
        (route) => false); //In any case Navigate back to start page
  }
}
