import '../../utils/base_app_utils.dart';

class AudioFile {
  final String id;
  final String additionalInfo;
  final String title;
  final String link;
  final String destinationPath;
  final String fileName;
  final Duration initPosition;
  final Duration lastPosition;
  final Duration totalDuration;

  AudioFile({
    required this.id,
    this.additionalInfo='',
    required this.title,
    required this.link,
    required this.destinationPath,
    required this.fileName,
    this.initPosition = Duration.zero,
    this.lastPosition = Duration.zero,
    this.totalDuration = Duration.zero,
  });

  String get localPath => joinParts(destinationPath, fileName);

  bool get isDownloaded {
    return isFileExist(destinationDirPath: destinationPath, fileName: fileName);
  }
}
