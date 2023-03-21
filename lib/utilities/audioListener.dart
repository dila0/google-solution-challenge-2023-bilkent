import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
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
  final int silenceSecondsThreshold = 6;
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
  AssetsAudioPlayer player;
  late NoiseMeter noiseMeter;
  double noiseLevel = 0;
  bool talking = false;
  int stopSpeaking = 0;
  bool timerStarted = false;
  bool logic = true;
  bool triggerWordEnabled;
  int silenceCount = 0;
  //Initialize everything
  //The constructor takes in two functions as parameters
  audioListener(this.emergency, this.userStoppedTalking, this.ErrorOnPorcupine,
      this.player, this.triggerWordEnabled) {
    //the constructor initializes both Porcupine and NoiseMeter objects
    if (triggerWordEnabled) {
      createPorcupineManager();
    }
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
    if (player.isPlaying.value == false) {
      if (noiseReading.meanDecibel > speakingThreshold) {
        talking = true;
        logic = false;
        silenceCount = 0;
      } else {
        if (!logic) {
          if (silenceCount == silenceSecondsThreshold) {
            silenceCount = 0;
            talking = false;
            stopSpeaking++; //for debugging
            userStoppedTalking(); //User stopped talking, call the appropriate function
            logic = true;
          } else {
            if (!timerStarted) {
              Timer(Duration(seconds: 1), () {
                timerStarted = false;
                silenceCount++;
              });
              timerStarted = true;
            }
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
