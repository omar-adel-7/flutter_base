import 'dart:async';
import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_base/BaseConfiguration.dart';
import 'package:flutter_base/core/audio_player/audio_util.dart';
import 'package:flutter_base/core/utils/FileUtils.dart';
import 'package:flutter_base/core/utils/base_app_utils.dart';
import 'package:flutter_base/core/utils/toast_manager.dart';
import 'package:flutter_base/data/repositories/base_local_database_repository.dart';
import 'audio_player_handler.dart';
import 'model/audio_file.dart';
import 'model/player_position.dart';

const String playerNotificationIconName = 'audio_notification_big_icon.png';

Future<void> copyPlayerNotificationBigIconToAppFolder({
  String? assetsPath,
  required String playerNotificationIconPath,
}) async {
  if (!File(playerNotificationIconPath).existsSync()) {
    try {
      await copyAssetDrawableToAppFolder(
        destinationFilePath: playerNotificationIconPath,
        assetFileName: playerNotificationIconName,
        assetsPath: assetsPath,
      );
    } catch (e) {
      customBaseLog(e.toString());
    }
  }
}

class MyBaseAudioManager extends AudioPlayerHandler {
  String getPlayerNotificationBigIconPath() {
    return playerNotificationIconPath;
  }

  late String playerNotificationIconPath;

  late BaseLocalDatabaseRepository baseLocalDatabaseRepository;

  AudioUtil audioUtil = AudioUtil();
  String appNotificationTitle = '';
  String appNoInternetMessage = '';
  List<AudioFile> audioFilesList = [];
  int playIndex = -1;

  MyBaseAudioManager(
    this.baseLocalDatabaseRepository,
    this.playerNotificationIconPath,
  ) {
    customLog('MyBaseAudioManager call base constructor');
    audioUtil.myBaseAudioManager = this;
  }

  playOtherSound(
    AudioFile audioFile,
    String appNotificationTitle,
    String appNoInternetMessage, {
    List<AudioFile>? audioFilesList,
    int? playIndex,
  }) async {
    this.appNotificationTitle = appNotificationTitle;
    this.appNoInternetMessage = appNoInternetMessage;
    await stop();
    if (audioFilesList != null) {
      this.audioFilesList.clear();
      this.audioFilesList.addAll(audioFilesList);
      if (playIndex != null) {
        this.playIndex = playIndex;
      }
    }
    playOtherSoundWork(audioFile);
  }

  Future<void> playOtherSoundWork(AudioFile audioFile) async {
    bool hasNetwork = await hasRealInternet();
    if (!audioFile.isDownloaded && !hasNetwork) {
      ToastManger.showToast(this.appNoInternetMessage);
    } else {
      String artUri = getPlayerNotificationBigIconPath();
      String mediaItemId = audioFile.id;
      mediaItem.add(
        MediaItem(
          id: mediaItemId,
          album: this.appNotificationTitle,
          title: audioFile.title,
          artUri: Uri.file(artUri),
        ),
      );
      AudioSource audioSource = audioFile.isDownloaded
          ? AudioSource.uri(Uri.file(audioFile.localPath), tag: mediaItemId)
          : AudioSource.uri(Uri.parse(audioFile.link), tag: mediaItemId);
      try {
        await audioPlayer.setAudioSource(audioSource);
        currentAudioFileNotifier.value = audioFile;
        play();
        await seek(
          Duration(milliseconds: audioFile.initPosition.inMilliseconds),
        );
      } catch (e) {
        customBaseLog('MyPlayerError occured: $e');
      }
    }
  }

  @override
  Future<void> pause() async {
    await super.pause();
  }

  Future<void> resume() async {
    play();
  }

  @override
  Future<void> seek(Duration position) async {
    if (isPlayerExist) {
      await callBaseSeek(position);
    }
  }

  Future<void> callBaseSeek(Duration position) async {
    await super.seek(position);
  }

  @override
  Future<void> stop() async {
    await super.stop();
  }

  @override
  Future<void> skipToNext() async {
    customLog('MyBaseAudioManager skipToNext');
    if (audioFilesList.isNotEmpty) {
      if (playIndex + 1 != audioFilesList.length) {
        playIndex++;
      } else {
        playIndex = 0;
      }
      playPlayListMedia();
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (audioFilesList.isNotEmpty) {
      if (playIndex - 1 >= 0) {
        playIndex--;
      } else {
        playIndex = audioFilesList.length - 1;
      }
      playPlayListMedia();
    }
  }

  void playPlayListMedia() async {
    await stop();
    playOtherSoundWork(audioFilesList[playIndex]);
  }

  @override
  completedCallback() async {
    super.completedCallback();
    await stop();
  }

  @override
  currentIndexStreamCallback(int? currentIndex) {}

  @override
  customPositionStreamCallback(PlayerPosition playerPosition) async {
    customBaseLog(
      "customPositionStreamCallback playerPosition $playerPosition",
    );
  }

  bool get isPlayerExist => playerStateNotifier.value.isPlayerExist;

  String? get currentItemId {
    if (isPlayerExist) {
      if (audioPlayer.audioSource?.sequence.isNotEmpty == true) {
        final index = audioPlayer.currentIndex;
        customBaseLog(
          "currentItemId audioPlayer.audioSource?.sequence ${audioPlayer.audioSource?.sequence.length}",
        );
        customBaseLog(
          "currentItemId audioPlayer.currentIndex ${audioPlayer.currentIndex}",
        );
        customBaseLog("currentItemId index $index");
        if (index != null &&
            index >= 0 &&
            index < audioPlayer.audioSource!.sequence.length) {
          String? tag = audioPlayer.audioSource!.sequence[index].tag;
          customBaseLog("currentItemId tag $tag");
          return tag;
        }
      }
    }
    customBaseLog("currentItemId null");
    return null;
  }

  final assetsAudioPlayer = AudioPlayer();

  Future<void> playAssetsFile(String assetsFileFullPath) async {
    await assetsAudioPlayer.stop();
    await assetsAudioPlayer.setAsset(assetsFileFullPath);
    assetsAudioPlayer.play();
  }
}
