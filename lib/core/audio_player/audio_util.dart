import 'package:flutter_base/core/audio_player/my_base_audio_manager.dart';

class AudioUtil {

  double speed = 1;
  late MyBaseAudioManager myBaseAudioManager;

  AudioUtil();

  void adjustSpeed(double sp) {
    if (sp != speed) {
      speed = sp;
      myBaseAudioManager.audioPlayer.setSpeed(sp);
    }
  }

}
