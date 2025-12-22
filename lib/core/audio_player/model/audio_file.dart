class AudioFile {
  final String id;
  final String title;
  final String sourcePath;
  final bool isLocal;
  final Duration initPosition;
  final Duration lastPosition;
  final Duration totalDuration;

  AudioFile({
    required this.id,
    required this.title,
    required this.sourcePath,
    required this.isLocal,
    this.initPosition = Duration.zero,
    this.lastPosition = Duration.zero,
    this.totalDuration = Duration.zero,
  });
}
