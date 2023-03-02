import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'snack_bar_utility.dart';

class FirestoreUtility {
  static final _fireStore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;
  static void saveUserData(
      {required String name,
      required String surname,
      required String phoneNumber}) {
    _fireStore.collection('users').doc(_auth.currentUser?.uid).set({
      'name': name,
      'surname': surname,
      'phone': phoneNumber
    }).catchError((error) => {print(error)});

    //TODO handle error
  }

  static void updateContacts(List<String> contacts) {
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'emergencyContacts': contacts}).catchError(
            (error) => {print(error)}); //TODO handle error
  }

  static void updateName(String name) {
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'name': name}).catchError(
            (error) => {print(error)}); //TODO handle error
  }

  static void updateSurname(String surname) {
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'surname': surname}).catchError(
            (error) => {print(error)}); //TODO handle error
  }

  static void updatePhone(String phone) {
    _fireStore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'phone': phone}).catchError(
            (error) => {print(error)}); //TODO handle error
  }
}
