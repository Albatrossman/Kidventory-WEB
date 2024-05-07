enum WeekDay {
  sunday('Sunday'),
  monday('Monday'),
  tuesday('Tuesday'),
  wednesday('Wednesday'),
  thursday('Thursday'),
  friday('Friday'),
  saturday('Saturday');

  const WeekDay(this.label);
  final String label;

  static WeekDay now() {
    DateTime today = DateTime.now();
    int weekdayIndex = today.weekday;
    WeekDay todayWeekDay = WeekDay.values[(weekdayIndex % 7)];
    return todayWeekDay;
  }
}