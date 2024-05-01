class DateTimeSerializer {
  static String toJson(DateTime dateTime) => '${dateTime.toUtc().toIso8601String().split('.')[0]}Z';
}
