import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen.dart';

extension DateTimeFormatting on DateTime {
  String formatDate({bool useShortFormat = false}) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    if (isSameDay(today)) {
      return "Today";
    } else {
      if (useShortFormat) {
        return DateFormat.yMMMd().format(toLocal());
      } else {
        return DateFormat.yMMMMd().format(toLocal());
      }
    }
  }

  DateTime copyWithTime(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
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

  TimeOfDay get timeOfDay => TimeOfDay(hour: hour, minute: minute);

  DateTime get firstDayOfMonth => DateTime(year, month, 1);

  DateTime get atStartOfDay => DateTime(year, month, day);
}
