import 'package:flutter/foundation.dart';

class messageData extends ChangeNotifier{

  String customMessage = " I NEED HELP LOL";

  void setMessage(String name){
    customMessage = name;
    notifyListeners();
    print("IN THE FUNCTION");
  }

}