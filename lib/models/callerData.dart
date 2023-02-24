import 'package:flutter/foundation.dart';

class callerData extends ChangeNotifier{

  String callerName = "Father";

  void setCallerName(String name){
    callerName = name;
    notifyListeners();
    print("IN THE FUNCTION");
  }
}