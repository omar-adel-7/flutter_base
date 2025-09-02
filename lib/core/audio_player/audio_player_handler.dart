import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_base/BaseConfiguration.dart';
import 'package:flutter_base/core/utils/base_app_utils.dart';
import 'package:rxdart/rxdart.dart';

import 'model/my_player_state.dart';
import 'model/my_processing_state.dart';
import 'model/player_position.dart';

/// An [AudioHandler] for playing a single item.
class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final audioPlayer = AudioPlayer();

  final playerStateNotifier = ValueNotifier<MyPlayerState>(
    MyPlayerState(false, MyProcessingState.idle),
  );

  final playerPositionNotifier = ValueNotifier<PlayerPosition>(
    PlayerPosition(const Duration(), const Duration(), const Duration()),
  );

  Stream<PlayerPosition> get playerPositionStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PlayerPosition>(
        audioPlayer.positionStream,
        audioPlayer.bufferedPositionStream,
        audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PlayerPosition(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  /// Initialise our audio handler.
  AudioPlayerHandler() {
    audioPlayer.playbackEventStream.listen(
      (PlaybackEvent event) {
        final playing = audioPlayer.playing;
        playbackState.add(
          playbackState.value.copyWith(
            controls: [
              MediaControl.rewind,
              if (playing) MediaControl.pause else MediaControl.play,
              MediaControl.stop,
              MediaControl.fastForward,
            ],
            systemActions: const {
              MediaAction.seek,
              MediaAction.seekForward,
              MediaAction.seekBackward,
            },
            androidCompactActionIndices: const [0, 1, 3],
            processingState: const {
              ProcessingState.idle: AudioProcessingState.idle,
              ProcessingState.loading: AudioProcessingState.loading,
              ProcessingState.buffering: AudioProcessingState.buffering,
              ProcessingState.ready: AudioProcessingState.ready,
              ProcessingState.completed: AudioProcessingState.completed,
            }[audioPlayer.processingState]!,
            repeatMode: const {
              LoopMode.off: AudioServiceRepeatMode.none,
              LoopMode.one: AudioServiceRepeatMode.one,
              LoopMode.all: AudioServiceRepeatMode.all,
            }[audioPlayer.loopMode]!,
            shuffleMode: (audioPlayer.shuffleModeEnabled)
                ? AudioServiceShuffleMode.all
                : AudioServiceShuffleMode.none,
            playing: playing,
            updatePosition: audioPlayer.position,
            bufferedPosition: audioPlayer.bufferedPosition,
            speed: audioPlayer.speed,
            queueIndex: event.currentIndex,
          ),
        );
      },
      // Catching errors during playback (e.g. lost network connection) // tested and worked in case of invalid url
      onError: (Object e, StackTrace st) async {
        await stop();
      },
    );

    // So that our clients (the Flutter UI and the system notification) know
    // what state to display, here we set up our audio handler to broadcast all
    // playback state changes as they happen via playbackState...
    //audioPlayer.playbackEventStream.map(transformEvent).pipe(playbackState);
    // ... and also the current media item via mediaItem.

    listenToPlayerState();
    listenToCurrentIndex();
    listenToPosition();
    listenToDuration();
  }

  @override
  Future<void> play() async {
    await audioPlayer.play();
  }

  @override
  Future<void> pause() async {
    await audioPlayer.pause();
  }

  @override
  Future<void> seek(Duration position) async {
    await audioPlayer.seek(position, index: audioPlayer.currentIndex);
  }

  @override
  Future<void> fastForward() async {
    var seekDuration = Duration(seconds: audioPlayer.position.inSeconds + 10);
    seek(seekDuration);
  }

  @override
  Future<void> rewind() async {
    int seconds = audioPlayer.position.inSeconds - 10;
    if (seconds < 0) {
      seconds = 0;
    }
    var seekDuration = Duration(seconds: seconds);
    seek(seekDuration);
  }

  @override
  Future<void> stop() async {
    await audioPlayer.stop();
    playerStateNotifier.value = MyPlayerState(false, MyProcessingState.idle);
    playerPositionNotifier.value = PlayerPosition(
      const Duration(),
      const Duration(),
      const Duration(),
    );
  }

  Future<void> shuffle() async {
    await audioPlayer.setShuffleModeEnabled(true);
  }

  Future<void> unShuffle() async {
    await audioPlayer.setShuffleModeEnabled(false);
  }

  Future<void> repeatForEver() async {
    await audioPlayer.setLoopMode(LoopMode.one);
  }

  Future<void> unRepeat() async {
    await audioPlayer.setLoopMode(LoopMode.off);
  }

  listenToPlayerState() {
    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        completedCallback();
      } else {
        playerStateNotifier.value = MyPlayerState(
          playerState.playing,
          getMyProcessingState(playerState.processingState),
        );
      }
    });
  }

  void listenToCurrentIndex() {
    audioPlayer.currentIndexStream.listen((index) {
      currentIndexStreamCallback(index);
    });
  }

  listenToPosition() {
    customBaseLog("bnbnbnbnb");
    playerPositionStream.listen((playerPosition) {
      playerPositionNotifier.value = playerPosition;
      customPositionStreamCallback(playerPosition);
    });
  }

  listenToDuration() {
    audioPlayer.durationStream.listen((duration) {
      var index = audioPlayer.currentIndex;
      // customBaseLog("listenToDuration index = "
      //     "$index");
      if (index == null) {
        return;
      }
      // customBaseLog("listenToDuration audioPlayer.playerState.playing = "
      //     "${audioPlayer.playerState.playing}");
      // customBaseLog("listenToDuration audioPlayer.playerState.processingState = "
      //     "${audioPlayer.playerState.processingState}");

      if (audioPlayer.playerState.playing == false &&
          audioPlayer.playerState.processingState == ProcessingState.idle)
        return;
      final newMediaItem = mediaItem.valueOrNull?.copyWith(duration: duration);
      mediaItem.add(newMediaItem);
    });
  }

  completedCallback() async {
    seek(Duration.zero);
  }

  void currentIndexStreamCallback(int? currentIndex) {}

  void customPositionStreamCallback(PlayerPosition playerPosition) {}

  bool get isPlaying {
    return playerStateNotifier.value.isPlaying;
  }

  bool get isPaused {
    return playerStateNotifier.value.isPaused;
  }

  bool get isLoadingOrBuffering {
    return playerStateNotifier.value.isLoadingOrBuffering;
  }

}
