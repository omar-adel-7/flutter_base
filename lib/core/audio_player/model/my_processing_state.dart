import 'package:just_audio/just_audio.dart';

enum MyProcessingState {
  /// The player has not loaded an [AudioSource].
  idle,

  /// The player is loading an [AudioSource].
  loading,

  /// The player is buffering audio and unable to play.
  buffering,

  /// The player is has enough audio buffered and is able to play.
  ready,

  /// The player has reached the end of the audio.
  completed,
}

MyProcessingState getMyProcessingState(ProcessingState processingState) {
  switch (processingState) {
    case ProcessingState.idle:
      return MyProcessingState.idle;
    case ProcessingState.loading:
      return MyProcessingState.loading;
    case ProcessingState.buffering:
      return MyProcessingState.buffering;
    case ProcessingState.ready:
      return MyProcessingState.ready;
    case ProcessingState.completed:
      return MyProcessingState.completed;
  }
}
