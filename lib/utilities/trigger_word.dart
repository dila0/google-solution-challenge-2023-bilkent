import 'package:porcupine_flutter/porcupine.dart';
import 'package:porcupine_flutter/porcupine_error.dart';
import 'package:porcupine_flutter/porcupine_manager.dart';

class TriggerWord {
  static const String accessKey =
      "fKxd4fHCiFw3XWBTftKAv4HZcIPR/L9+YfCBmpUWPv6oINnmp/2TWQ==";
  PorcupineManager? porcupineManager;
  //function to call when trigger word is detected
  Function callBackFunction;

  TriggerWord({required this.callBackFunction}) {
    callBackFunction = callBackFunction;
  }

  //function below calls the callBackFunction if trigger word is detected
  void _callBackLocal(int keywordIndex) {
    if (keywordIndex == 0) {
      callBackFunction;
    }
  }

  void createPorcupineManager() async {
    print("entered1");
    try {
      porcupineManager = await PorcupineManager.fromBuiltInKeywords(
          accessKey, [BuiltInKeyword.AMERICANO], _callBackLocal);
      porcupineManager?.start();
    } on PorcupineException catch (err) {
      print("big error big big error");
      print(err);
    }
  }
}
