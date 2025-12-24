FormatEntity formatTime(DateTime time) {
  final dt = time;
  final e = dt.isUtc ? dt.toLocal() : dt;
  final h = e.hour % 12 == 0 ? 12 : e.hour % 12;
  final p = e.hour >= 12 ? 'م' : 'ص';

  final now = DateTime.now();

  return FormatEntity(
    day: e.day,
    month: e.month,
    year: e.year,
    hour: h,
    minut: e.minute,
    ap: p,
    formatC: "$h:${e.minute} $p",
    format:
        "${e.day}/${e.month}${now.year == e.year ? "" : "${e.year.toString().substring(2)}/"}",
    formatH:
        "${e.day}/${e.month}${now.year == e.year ? "" : "${e.year.toString().substring(2)}/"} $h:${e.minute} $p",
  );
}

String formatDouble(double number) {
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  return number.toString().replaceAll(regex, '');
}

class FormatEntity {
  final int day;
  final int month;
  final int year;
  final int hour;
  final int minut;
  final String ap;
  final String format;
  final String formatH;
  final String formatC;
  const FormatEntity({
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.minut,
    required this.ap,
    required this.format,
    required this.formatH,
    required this.formatC,
  });
}
