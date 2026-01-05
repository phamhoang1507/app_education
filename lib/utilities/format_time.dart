String decimalHourToTime(double value) {
  final int hours = value.floor();
  final int minutes = ((value - hours) * 60).round();

  final String h = hours.toString();
  final String m = minutes.toString().padLeft(2, '0');

  return '$h:$m';
}