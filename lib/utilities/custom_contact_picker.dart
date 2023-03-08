import 'dart:async';

import 'package:flutter/services.dart';

//the code below is a modification to https://pub.dev/packages/flutter_native_contact_picker/install

class FlutterContactPicker {
  static const MethodChannel _channel =
      MethodChannel('flutter_native_contact_picker');

  /// Method to call native code and get contact detail
  static Future<Contact?> selectContact() async {
    final Map<dynamic, dynamic>? result =
        await _channel.invokeMethod('selectContact');
    if (result == null) {
      return null;
    }
    return Contact.fromMap(result);
  }
}

/// Represents a contact selected by the user.
class Contact {
  Contact({this.fullName = "", List<String>? phoneNumbers}) {
    if (phoneNumbers == null) {
      phoneNumber = "-";
    } else if (phoneNumbers.length == 0) {
      phoneNumber = "-";
    } else {
      phoneNumber = phoneNumbers.first;
    }
  }

  factory Contact.fromMap(Map<dynamic, dynamic> map) => Contact(
      fullName: map['fullName'],
      // phoneNumber: new PhoneNumber.fromMap(map['phoneNumber']));
      phoneNumbers: map['phoneNumbers'].cast<String>());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Contact &&
        other.phoneNumber == phoneNumber &&
        other.fullName == fullName;
  }

  String fullName;

  String phoneNumber = "";

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
