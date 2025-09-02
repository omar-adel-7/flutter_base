import 'my_processing_state.dart';

class MyPlayerState {
  /// Whether the player will play when [processingState] is
  /// [ProcessingState.ready].
  final bool toPlay;

  /// The current processing state of the player.
  final MyProcessingState processingState;

  MyPlayerState(this.toPlay, this.processingState);

  @override
  String toString() => 'toPlay=$toPlay,processingState=$processingState';

  @override
  int get hashCode => Object.hash(toPlay, processingState);

  @override
  bool operator ==(Object other) =>
      other.runtimeType == runtimeType &&
          other is MyPlayerState &&
          other.toPlay == toPlay &&
          other.processingState == processingState;


  bool get isPlaying => toPlay && isReady ;
  bool get isPaused => !toPlay && isReady ;
  bool get isLoadingOrBuffering => isLoading || isBuffering;
  bool get isCompleted => processingState == MyProcessingState.completed;
  bool get isIdle => processingState == MyProcessingState.idle;
  bool get isLoading => processingState == MyProcessingState.loading;
  bool get isBuffering => processingState == MyProcessingState.buffering;
  bool get isReady => processingState == MyProcessingState.ready;
  bool get isPlayerExist =>
      isPlaying ||
          !(isIdle || isCompleted);
}