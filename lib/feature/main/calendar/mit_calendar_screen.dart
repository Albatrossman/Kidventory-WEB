import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/util/extension/color_extension.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/di/app_module.dart';
import 'package:kidventory_flutter/feature/main/calendar/calendar_screen_viewmodel.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:calendar_view/calendar_view.dart';

enum CalendarViewMode {
  day,
  week,
  month,
}

class MitCalendarScreen extends StatefulWidget {
  const MitCalendarScreen({
    super.key,
  });

  @override
  State<MitCalendarScreen> createState() {
    return _MitCalendarScreenState();
  }
}

class _MitCalendarScreenState extends State<MitCalendarScreen>
    with NavigationMixin, MessageMixin {
  late final CalendarScreenViewModel _viewModel;
  final EventController _calendarController = EventController();

  CalendarViewMode _calendarViewMode = CalendarViewMode.day;
  List<Appointment> _appointments = [];
  DateTime? _fetchedStartDate;
  DateTime? _fetchedEndDate;

  @override
  void initState() {
    super.initState();
    _viewModel = CalendarScreenViewModel(getIt<UserApiService>());
    // Initial fetch for the current month; adjust based on your needs.
    DateTime start = DateTime.now().firstDayOfMonth;
    fetchAndUpdateSessions(start, start.plusMonths(1));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void fetchAndUpdateSessions(DateTime start, DateTime end) {
    if (_fetchedStartDate != null &&
        _fetchedEndDate != null &&
        start.compareTo(_fetchedStartDate!) >= 0 &&
        end.compareTo(_fetchedEndDate!) <= 0) {
      return;
    }

    _fetchedStartDate = start;
    _fetchedEndDate = end;

    _viewModel
        .getUpcomingSessionsBetweenDates(start, end)
        .whenComplete(() => {})
        .then(
          (value) => {
            setState(
              () {
                _viewModel.state.upcomingSessions.map(
                  (session) {
                    final EventColor eventColor = EventColor.values.firstWhere(
                      (e) => e.name == session.color.toLowerCase(),
                    );

                    final event = CalendarEventData(
                      title: session.title,
                      titleStyle:
                          Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: eventColor.getReadableTextColor(),
                          ),
                      date: session.startDateTime,
                      startTime: session.startDateTime,
                      endTime: session.endDateTime,
                      event: session,
                      color: eventColor.value,
                    );

                    _calendarController.add(event);
                  },
                ).toList();
              },
            )
          },
          onError: (error) => {
            snackbar((error as DioException).message ?? "Something went wrong"),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        viewSwitcher(context),
        const SizedBox(
          height: 16,
        ),
        Expanded(
            child: CalendarControllerProvider(
          controller: _calendarController,
          child: switch (_calendarViewMode) {
            CalendarViewMode.day => DayView(
                headerStyle: HeaderStyle(
                  decoration: headerBoxDecoration(context),
                ),
              ),
            CalendarViewMode.week => WeekView(
                weekNumberBuilder: (firstDayOfWeek) {
                  //this is to remove the confusing week number above the time
                  return null;
                },
                headerStyle: HeaderStyle(
                  decoration: headerBoxDecoration(context),
                ),
              ),
            CalendarViewMode.month => MonthView(
                headerStyle: HeaderStyle(
                  decoration: headerBoxDecoration(context),
                ),
              ),
          },
        )),
      ],
    ));
  }

  Widget viewSwitcher(BuildContext context) {
    return CupertinoSegmentedControl<CalendarViewMode>(
      // selectedColor: Theme.of(context).colorScheme.primaryContainer,
      // thumbColor: Theme.of(context).colorScheme.primaryContainer,
      groupValue: _calendarViewMode,
      onValueChanged: (CalendarViewMode? value) {
        setState(() {
          _calendarViewMode = value ?? CalendarViewMode.day;
        });
      },
      children: const <CalendarViewMode, Widget>{
        CalendarViewMode.day: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text("Day"),
        ),
        CalendarViewMode.week: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text("Week"),
        ),
        CalendarViewMode.month: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text("Month"),
        ),
      },
    );
  }

  BoxDecoration headerBoxDecoration(BuildContext context) {
    return BoxDecoration(
      // color: Theme.of(context).colorScheme.primaryContainer,
      border: Border.all(
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
