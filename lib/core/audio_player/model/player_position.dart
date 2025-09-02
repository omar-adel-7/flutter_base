class PlayerPosition {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;

  PlayerPosition(this.position, this.bufferedPosition, this.duration);
  PlayerPosition.zero()
      : position = const Duration(),
        duration = const Duration(),
        bufferedPosition = const Duration();
}
