import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/di/app_module.dart';
import 'package:kidventory_flutter/feature/main/calendar/calendar_screen_viewmodel.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    super.key,
  });

  @override
  State<CalendarScreen> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen>
    with NavigationMixin, MessageMixin {
  late final CalendarScreenViewModel _viewModel;

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
            setState(() {
              _appointments =
                  _viewModel.state.upcomingSessions.map<Appointment>(
                (session) {
                  return Appointment(
                    startTime: session.startDateTime,
                    endTime: session.endDateTime,
                    subject: session.title,
                    color: Colors
                        .blue, // Convert session.color to a Flutter Color if necessary
                  );
                },
              ).toList();
            })
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
          Expanded(
            child: SfCalendar(
              allowedViews: const [
                CalendarView.schedule,
                CalendarView.day,
                CalendarView.week,
                CalendarView.month,
              ],
              backgroundColor: Theme.of(context).colorScheme.background,
              viewNavigationMode: ViewNavigationMode.snap,
              showTodayButton: true,
              dataSource: AppointmentDataSource(_appointments),
              onViewChanged: (ViewChangedDetails viewChangedDetails) {
                // Fetch sessions based on the current view's date range
                final DateTime visibleStart =
                    viewChangedDetails.visibleDates.first;
                final DateTime visibleEnd =
                    viewChangedDetails.visibleDates.last;
                fetchAndUpdateSessions(visibleStart, visibleEnd);
              },
            ),
          )
        ],
      ),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
