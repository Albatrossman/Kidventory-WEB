import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String formatDate() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    if (this == today) {
      return "Today";
    } else {
      return DateFormat.yMMMMd().format(this);
    }
  }

  DateTime plusMonths(int months) {
    if (months == 0) return this;

    int newYear = year + (month + months - 1) ~/ 12;
    int newMonth = (month + months - 1) % 12 + 1;
    int newDay = day;

    int lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;
    if (newDay > lastDayOfNewMonth) {
      newDay = lastDayOfNewMonth;
    }

    return DateTime(newYear, newMonth, newDay);
  }

  DateTime get firstDayOfMonth {
    return DateTime(year, month, 1);
  }
}
