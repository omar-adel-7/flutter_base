import 'package:flutter_base/core/audio_player/my_audio_manager.dart';

class AudioUtil {

  double speed = 1;
  late MyAudioManager myAudioManager;

  AudioUtil();

  void adjustSpeed(double sp) {
    if (sp != speed) {
      speed = sp;
      myAudioManager.audioPlayer.setSpeed(sp);
    }
  }

}
