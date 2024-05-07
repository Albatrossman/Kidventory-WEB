import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/model/event_session_dto.dart';
import 'package:kidventory_flutter/core/ui/component/clickable.dart';
import 'package:kidventory_flutter/core/ui/component/sheet_header.dart';
import 'package:table_calendar/table_calendar.dart';

class SessionPicker extends StatelessWidget {
  final bool loading;
  final List<EventSessionDto> sessions;
  final EventSessionDto? selected;
  final Function(EventSessionDto) onSessionPicked;

  const SessionPicker({
    super.key,
    required this.loading,
    required this.selected,
    required this.sessions,
    required this.onSessionPicked,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                            (s) => isSameDay(s.startDateTime, selectedDay),
                      );
                      onSessionPicked(session);
                    } catch (e) {
                      // Nothing yet
                    }
                  },
                  calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        EventSessionDto? session = sessions.firstWhereOrNull((element) => isSameDay(element.startDateTime, day));
                        bool dayHasSession = session != null;
                        return Clickable(
                          onPressed: () => { session != null ? onSessionPicked(session) : null },
                          child: Container(
                            margin: const EdgeInsets.all(4.0),
                            alignment: Alignment.center,
                            child: Text(
                              day.day.toString(),
                              style: TextStyle(color: dayHasSession ? Theme.of(context).colorScheme.onSurface : Colors.grey.shade300),
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
                            color: dayHasSession ? Theme.of(context).colorScheme.primary : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            day.day.toString(),
                            style: TextStyle(color: dayHasSession ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primary.withAlpha(88)),
                          ),
                        );
                      },
                      selectedBuilder: (context, day, focusedDay) {
                        bool isSelected = isSameDay(day, selected?.startDateTime);
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            day.day.toString(),
                            style: TextStyle(color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface),
                          ),
                        );
                      },
                      outsideBuilder: (context, day, focusedDay) {
                        return const SizedBox.shrink();
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
        if (loading)
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300.withAlpha(200),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ]
    );
  }

  bool isSameDay(DateTime a, DateTime? b) {
    return a.year == b?.year && a.month == b?.month && a.day == b?.day;
  }
}
