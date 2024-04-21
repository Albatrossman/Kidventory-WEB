extension DateTimeExtension on DateTime {
  String toFormattedTextString() {
    var date = toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    return formattedDate;
  }
}
