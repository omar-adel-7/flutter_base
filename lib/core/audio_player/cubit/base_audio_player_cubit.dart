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
    required this.myBaseAudioManager,
    required this.baseHiveStore,
    required this.baseLocalDatabaseRepository,
  }) : super(AudioPlayerInitialState()) {
    initialize();
  }

  final BaseHiveStore baseHiveStore;
  final MyBaseAudioManager myBaseAudioManager;
  final BaseLocalDatabaseRepository baseLocalDatabaseRepository;

  int playSpeed = 1;
  double speed = 1;

  ValueNotifier<AudioFile?> get currentAudioFileNotifier =>
      myBaseAudioManager.currentAudioFileNotifier;

  ValueNotifier<MyPlayerState> get playerStateNotifier =>
      myBaseAudioManager.playerStateNotifier;

  ValueNotifier<PlayerPosition> get playerPositionNotifier =>
      myBaseAudioManager.playerPositionNotifier;

  void initialize() {
    loadSetting();
  }

  void loadSetting() {}

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

  startPlaying(BuildContext context) {}

  seekSecondsPrevious() {
    myBaseAudioManager.rewind();
  }

  seekSecondsForward() {
    myBaseAudioManager.fastForward();
  }

  String? get currentItemId {
    return myBaseAudioManager.currentItemId;
  }

  bool get isPlayerExist {
    return myBaseAudioManager.isPlayerExist;
  }

  bool get isPlaying {
    return myBaseAudioManager.isPlaying;
  }

  bool get isPaused {
    return myBaseAudioManager.isPaused;
  }

  bool get isLoadingOrBuffering => myBaseAudioManager.isLoadingOrBuffering;

  Future<void> playNormalSoundOrPauseOrStop(
    AudioFile audioFile,
    String appNotificationTitle,
    String appNoInternetMessage, {
    List<AudioFile>? audioFilesList,
    int? playIndex,
  }) async {
    customBaseLog(
      "playNormalSound audioFile link = ${audioFile.link} localPath = ${audioFile.localPath}",
    );
    if (audioFile.id == currentItemId) {
      if (isPlaying) {
        await myBaseAudioManager.pause();
        //await stopSound();
      } else if (isPaused) {
        myBaseAudioManager.resume();
      }
    } else {
      await myBaseAudioManager.playNormalSound(
        audioFile,
        appNotificationTitle,
        appNoInternetMessage,
        audioFilesList: audioFilesList,
        playIndex: playIndex,
      );
    }
  }

  play() async {
    await myBaseAudioManager.play();
  }

  pause() async {
    await myBaseAudioManager.pause();
  }

  playNextSound() async {
    await myBaseAudioManager.skipToNext();
  }

  playPreviousSound() async {
    await myBaseAudioManager.skipToPrevious();
  }

  stopSound() async {
    await myBaseAudioManager.stop();
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
    await myBaseAudioManager.seek(duration);
  }

  fastForward() async {
    await myBaseAudioManager.fastForward();
  }

  Future<void> fastBackward() async {
    await myBaseAudioManager.rewind();
  }
}
