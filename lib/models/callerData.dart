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
    else if (callerName == "MOM") return 12;
    else if (callerName == "BOYFRIEND") return 15;
    else if (callerName == "BESTIE") return 10;

    return 0;

  }
}