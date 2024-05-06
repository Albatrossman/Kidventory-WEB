extension Extension on int {

  DateTime get birthday {
    DateTime now = DateTime.now();
    int yearsAgo = this;
    return DateTime(now.year - yearsAgo, 1, 1);
  }

}