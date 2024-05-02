import 'package:intl/intl.dart';

class DateSerializer {
  static String? toJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
}