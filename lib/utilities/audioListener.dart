import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:google_solution/utilities/snack_bar_utility.dart';
import 'package:porcupine_flutter/porcupine.dart';
import 'package:porcupine_flutter/porcupine_error.dart';
import 'package:porcupine_flutter/porcupine_manager.dart';
import 'package:noise_meter/noise_meter.dart';
import 'dart:async';

class audioListener {
  //API key
  FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  String accessKey = "INSERT_YOUR_API_KEY_HERE_IF_NEEDED";
  final int speakingThreshold = 80;

  //Emergency and Stopped functions that'll be given by the user
  Function emergency;
  Function userStoppedTalking;
  Function ErrorOnPorcupine;
  //Porcupine Utilities
  int wordCounter = 0;
  PorcupineManager? porcupineManager;
  bool isPorcupineRecording = false;

  //Noise Meter Utilities
  bool isNoiseRecording = false;
  StreamSubscription<NoiseReading>? noiseSubscription;
  late NoiseMeter noiseMeter;
  double noiseLevel = 0;
  bool talking = false;
  int stopSpeaking = 0;
  bool waitedThree = false;
  bool timerStarted = false;
  bool logic = true;

  //Initialize everything
  //The constructor takes in two functions as parameters
  audioListener(
      this.emergency, this.userStoppedTalking, this.ErrorOnPorcupine) {
    //the constructor initializes both Porcupine and NoiseMeter objects
    createPorcupineManager();
    noiseMeter = NoiseMeter(onNoiseError);
  }

  //Initialize Porcupine Manager
  void createPorcupineManager() async {
    await remoteConfig.fetchAndActivate();

    accessKey = remoteConfig.getValue('PORCUPINE_KEY').asString();
    try {
      porcupineManager = await PorcupineManager.fromBuiltInKeywords(
          accessKey, [BuiltInKeyword.AMERICANO], _wakeWordCallback);
      await porcupineManager?.start();
    } on PorcupineException catch (err) {
      ErrorOnPorcupine(
          "Error trying to start trigger word detection", err.message);
    }
  }

  //check if chosen word has been said
  void _wakeWordCallback(int keywordIndex) {
    if (keywordIndex == 0) {
      wordCounter++; //for debugging
      emergency(); //The words has been said, call the emergency function.
    }
  }

  //This has to be turned on in order for Porcupine to start listening
  void startPorcupine() async {
    try {
      await porcupineManager?.start();
      isPorcupineRecording = true;
    } on PorcupineException catch (ex) {
      print(ex);
    }
  }

  //To stop porcupine listener
  void stopPorcupine() async {
    await porcupineManager?.stop();
    isPorcupineRecording = false;
  }

  //Constant stream listening for Noise data
  void onNoiseData(NoiseReading noiseReading) {
    if (!this.isNoiseRecording) {
      this.isNoiseRecording = true;
    }
    noiseLevel = noiseReading.meanDecibel;
    if (noiseReading.meanDecibel > speakingThreshold) {
      talking = true;
      waitedThree = false;
      logic = false;
    } else {
      if (!logic) {
        if (waitedThree) {
          talking = false;
          stopSpeaking++; //for debugging
          userStoppedTalking(); //User stopped talking, call the appropriate function
          waitedThree = false;
          logic = true;
        } else {
          if (!timerStarted) {
            Timer(Duration(seconds: 3), () {
              waitedThree = true;
              timerStarted = false;
            });
            timerStarted = true;
          }
        }
      }
    }
  }

  //Not entirely necessary
  void onNoiseError(Object error) {
    print(error.toString());
    isNoiseRecording = false;
  }

  //This has to be turned on in order for Noise Meter to start listening
  void startNoiseMeter() {
    try {
      noiseSubscription = noiseMeter.noiseStream.listen(onNoiseData);
    } catch (err) {
      print(err);
    }
  }

  //Stops Noise Meter
  void stopNoiseMeter() {
    try {
      if (noiseSubscription != null) {
        noiseSubscription!.cancel();
        noiseSubscription = null;
      }
      isNoiseRecording = false;
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }
}
