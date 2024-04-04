import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../core/ui/component/session_card.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    super.key,
  });

  @override
  State<CalendarScreen> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<Appointment> _appointments = [];
  DateTime? _fetchedStartDate;
  DateTime? _fetchedEndDate;

  @override
  void initState() {
    super.initState();
    // Initial fetch for the current month; adjust based on your needs.
    DateTime start = DateTime.now().firstDayOfMonth;
    fetchAndUpdateSessions(start, start.plusMonths(1));
  }

  void fetchAndUpdateSessions(DateTime start, DateTime end) {
    if (_fetchedStartDate != null && _fetchedEndDate != null && start.compareTo(_fetchedStartDate!) >= 0 && end.compareTo(_fetchedEndDate!) <= 0) {
      return;
    }

    _fetchedStartDate = start;
    _fetchedEndDate = end;

    fetchSessions(start, end).then((sessions) {
      setState(() {
        _appointments = sessions.map<Appointment>((session) {
          return Appointment(
            startTime: session.startDateTime,
            endTime: session.endDateTime,
            subject: session.title,
            color: Colors.blue,  // Convert session.color to a Flutter Color if necessary
          );
        }).toList();
      });
    }).catchError((error) {
      // Handle any errors here
      print('Error fetching sessions: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text("Calendar"),
          ],
        ),
        Expanded(
          child: SfCalendar(
            allowedViews: const [
              CalendarView.schedule,
              CalendarView.day,
              CalendarView.week,
              CalendarView.month,
            ],
            viewNavigationMode: ViewNavigationMode.snap,
            showTodayButton: true,
            dataSource: AppointmentDataSource(_appointments),
            onViewChanged: (ViewChangedDetails viewChangedDetails) {
              // Fetch sessions based on the current view's date range
              final DateTime visibleStart = viewChangedDetails.visibleDates.first;
              final DateTime visibleEnd = viewChangedDetails.visibleDates.last;
              fetchAndUpdateSessions(visibleStart, visibleEnd);
            },
          ),
        )
      ],
    );
  }
}

Future<List<Session>> fetchSessions(DateTime start, DateTime end) async {
  String startDate = start.toUtc().toIso8601String();
  String endDate = end.toUtc().toIso8601String();

  final response = await http.get(
      Uri.parse('https://dev-kidsapi.softballforce.com/api/parent/getUserEventsSessionBetweenDays')
          .replace(queryParameters: {'startDate': startDate, 'endDate': endDate}),
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJ1c2VySWQiOiI2NGNmNWYwYjZkNjY5M2NiMmE1Y2QxZjQiLCJpc1N1YnNjcmliZSI6IkZhbHNlIiwic3ViIjoiYWJiYXNiYXZhcnNhZEBnbWFpbC5jb20iLCJ0eXBlIjoiVXNlciIsInJvbGVzIjoiIiwibmJmIjoxNzA4NDcxMzkzLCJleHAiOjE3MDkzMzUzOTIsImlhdCI6MTcwODQ3MTM5MywiaXNzIjoiaHR0cHM6Ly9kZXYta2lkc2lkZW50aXR5LnNvZnRiYWxsZm9yY2UuY29tIiwiYXVkIjoiQjBiNWU4ZHl5cEpBZDVZOEJhSDhFWmxJVmpaMS9Hc2VXN3NHQ2RDSGhKTT0ifQ.SkLmZSfj315l8elCe0y4r0tLFww_kMqt07V9kz510kQ',
        'Content-Type': 'application/json',
      },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final List<dynamic> results = jsonResponse['result']; // Accessing the 'result' field
    return results.map((data) => Session.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load sessions from API');
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}