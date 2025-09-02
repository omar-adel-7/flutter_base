extension DurationExtension on Duration {
  String get format {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(inHours);
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));
    return "${inHours == 0 ? "" : "$twoDigitHours:"}$twoDigitMinutes:$twoDigitSeconds";
  }
}
