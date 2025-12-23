import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/core/audio_player/model/audio_file.dart';
import 'package:flutter_base/core/audio_player/model/my_player_state.dart';
import 'package:flutter_base/core/audio_player/model/player_position.dart';
import 'package:flutter_base/core/audio_player/my_base_audio_manager.dart';
import 'package:flutter_base/core/cache/base_hive_store.dart';
import 'package:flutter_base/core/utils/base_app_utils.dart';
import 'package:flutter_base/data/repositories/base_local_database_repository.dart';
import 'audio_player_state.dart';

abstract class BaseAudioPlayerCubit extends Cubit<AudioPlayerState> {
  static BaseAudioPlayerCubit get(context) => BlocProvider.of(context);

  BaseAudioPlayerCubit({
    required this.myAudioManager,
    required this.baseHiveStore,
    required this.baseLocalDatabaseRepository,
  }) : super(AudioPlayerInitialState()) {
    initialize();
  }

  final BaseHiveStore baseHiveStore;
  final MyBaseAudioManager myAudioManager;
  final BaseLocalDatabaseRepository baseLocalDatabaseRepository;

  int playSpeed = 1;
  double speed = 1;


  ValueNotifier<AudioFile?> get currentAudioFileNotifier =>
      myAudioManager.currentAudioFileNotifier;

  ValueNotifier<MyPlayerState> get playerStateNotifier =>
      myAudioManager.playerStateNotifier;

  ValueNotifier<PlayerPosition> get playerPositionNotifier =>
      myAudioManager.playerPositionNotifier;

  void initialize() {
    loadSetting();
  }

  void loadSetting() {

  }

  savePlayerSettings({
    required BuildContext context,
    required bool willPlay,
  }) async {

    emitPlayerSettingsChangeAndPlayIfWanted(context, willPlay);
  }

  void emitPlayerSettingsChangeAndPlayIfWanted(
    BuildContext context,
    bool willPlay,
  ) {
    if (!isClosed) {
      emit(AudioPlayerSettingsChangedState());
    }
    if (willPlay) {
      startPlaying(context);
    }
  }

  startPlaying(BuildContext context) {

  }

  seekSecondsPrevious() {
    myAudioManager.rewind();
  }

  seekSecondsForward() {
    myAudioManager.fastForward();
  }


  String? get currentItemId {
    return myAudioManager.currentItemId;
  }

  bool get isPlayerExist {
    return myAudioManager.isPlayerExist;
  }

  bool get isPlaying {
    return myAudioManager.isPlaying;
  }

  bool get isPaused {
    return myAudioManager.isPaused;
  }

  bool get isLoadingOrBuffering => myAudioManager.isLoadingOrBuffering;

  Future<void> playOtherSoundOrPauseOrStop(
    AudioFile audioFile,
    String notificationTitle,
    String appNoInternetMessage,
  ) async {
    customBaseLog(
      "playOtherSound audioFile sourcePath = ${audioFile.sourcePath}",
    );
      if (audioFile.id == currentItemId) {
        if (isPlaying) {
          await myAudioManager.pause();
          //await stopSound();
        } else if (isPaused) {
          myAudioManager.resume();
        }
      } else {
        await myAudioManager.playOtherSound(
          audioFile,
          notificationTitle,
          appNoInternetMessage,
        );
      }
  }

  play() async {
    await myAudioManager.play();
  }

  pause() async {
    await myAudioManager.pause();
  }

  stopSound() async {
    await myAudioManager.stop();
  }

  void stopItemId(String id) async {
    if (isPlayerExist) {
      if (currentItemId == id) {
        stopSound();
      }
    }
  }

  void onSliderChanged(double value) async =>
      seek(Duration(milliseconds: value.toInt()));

  Future<void> seek(Duration duration) async {
    await myAudioManager.seek(duration);
  }

  fastForward() async {
    await myAudioManager.fastForward();
  }

  Future<void> fastBackward() async {
    await myAudioManager.rewind();
  }
}
