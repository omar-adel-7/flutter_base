import 'package:flutter_base/core/audio_player/my_base_audio_manager.dart';
import 'package:flutter_base/core/utils/base_app_utils.dart';
import 'package:just_audio/just_audio.dart';

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



enum PlayerError {
  localSourceError,
  remoteSourceError,
  generalError
}


bool isAudioFromLocalUrlSource(String urlSource) {
  customLog('isAudioFromLocalUrlSource urlSource $urlSource');
  return !urlSource.startsWith('http://') &&
      !urlSource.startsWith('https://');
}

bool isAudioFromLocalAudioSource(AudioSource source) {
  Uri? uri;
  if (source is UriAudioSource) {
    uri = source.uri;
  } else if (source is ClippingAudioSource) {
    final child = source.child;
    uri = child.uri;
  }

  customLog('isAudioFromLocalAudioSource uri?.scheme ${uri?.scheme}');
  return uri?.scheme == 'file' || uri?.scheme == 'asset';
}
