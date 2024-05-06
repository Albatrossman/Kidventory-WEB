import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime {
  String toFormattedTextString() {
    var date = toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    return formattedDate;
  }
}

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay roundedToNextQuarter() {
    int roundedMinute = (minute ~/ 15 + 1) * 15;
    int additionalHour = 0;

    if (roundedMinute >= 60) {
      additionalHour = roundedMinute ~/ 60;
      roundedMinute %= 60;
    }

    int newHour = (hour + additionalHour) % 24;
    return TimeOfDay(hour: newHour, minute: roundedMinute);
  }

  String get formatted {
    final hour = this.hour % 12 == 0 ? 12 : this.hour % 12; // Convert 24-hour time to 12-hour format
    final minute = this.minute.toString().padLeft(2, '0'); // Ensure two digits for minutes
    final amPm = this.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $amPm";
  }
}
