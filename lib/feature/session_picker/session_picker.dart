import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/model/event_session_dto.dart';
import 'package:kidventory_flutter/core/domain/model/event_session.dart';
import 'package:kidventory_flutter/core/ui/component/sheet_header.dart';
import 'package:table_calendar/table_calendar.dart';

class SessionPicker extends StatelessWidget {
  final List<EventSessionDto> sessions;
  final Function(EventSessionDto) onSessionPicked;

  const SessionPicker({
    super.key,
    required this.sessions,
    required this.onSessionPicked,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            const SheetHeader(title: Text('Session picker')),
            TableCalendar(
              firstDay: DateTime.utc(2020, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.month,
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) {
                return sessions.any((session) => isSameDay(session.startDateTime, day));
              },
              onDaySelected: (selectedDay, focusedDay) {
                try {
                  final EventSessionDto session = sessions.firstWhere(
                        (s) => isSameDay(s.startDateTime, selectedDay,),
                  );
                  onSessionPicked(session);
                } catch (e) {

                }
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  EventSessionDto? session = sessions.firstWhereOrNull((element) => isSameDay(element.startDateTime, day));
                  bool dayHasSession = session != null;
                  return CupertinoButton(
                    onPressed: () => { session != null ? onSessionPicked(session) : null },
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: dayHasSession ? Theme.of(context).colorScheme.secondary : Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(color: dayHasSession ? Theme.of(context).colorScheme.onSecondary : Colors.grey),
                      ),
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  bool dayHasSession = sessions.any((session) => isSameDay(session.startDateTime, day));
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: dayHasSession ? Theme.of(context).colorScheme.primary : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      day.day.toString(),
                      style: TextStyle(color: dayHasSession ? Theme.of(context).colorScheme.onPrimary : Colors.grey),
                    ),
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      day.day.toString(),
                      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
