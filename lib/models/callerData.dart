import 'package:flutter/foundation.dart';

class callerData extends ChangeNotifier{

  String callerName = "Father";

  void setCallerName(String name){
    callerName = name;
    notifyListeners();
    print("IN THE FUNCTION");
  }

  int getSoundNumber() {
    if (callerName == "DAD") return 9;
    else if (callerName == "Mother") return 13;
    else if (callerName == "BOYFRIEND") return 15;
    else if (callerName == "Friend") return 9;

    return 0;

  }
}