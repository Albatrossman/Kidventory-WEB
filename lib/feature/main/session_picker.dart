// import 'package:flutter/material.dart';
// import 'package:kidventory_flutter/core/domain/model/event_session.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class EventCalendarPicker extends StatelessWidget {
//   final List<EventSession> sessions;
//   final Function(EventSession) onSessionPicked;
//
//   const EventCalendarPicker({
//     super.key,
//     required this.sessions,
//     required this.onSessionPicked,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TableCalendar(
//       firstDay: DateTime.utc(2020, 10, 16),
//       lastDay: DateTime.utc(2030, 3, 14),
//       focusedDay: DateTime.now(),
//       calendarFormat: CalendarFormat.month,
//       availableCalendarFormats: const {CalendarFormat.month: 'Month'},
//       startingDayOfWeek: StartingDayOfWeek.monday,
//       onDaySelected: (selectedDay, focusedDay) {
//         final EventSession? session = sessions.firstWhere(
//           (s) => isSameDay(s.startDateTime, selectedDay),
//           orElse: () => null as EventSession?,
//         );
//
//         if (session != null) {
//           onSessionPicked(session);
//         }
//       },
//       calendarBuilders: CalendarBuilders(
//         defaultBuilder: (context, day, focusedDay) {
//           if (sessions.any((s) => isSameDay(s.startDateTime, day))) {
//             return Container(
//               margin: const EdgeInsets.all(4.0),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.secondary,
//                 shape: BoxShape.circle,
//               ),
//               child: Text(
//                 day.day.toString(),
//                 style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
//               ),
//             );
//           }
//           return null;
//         },
//       ),
//     );
//   }
//
//   bool isSameDay(DateTime a, DateTime b) {
//     return a.year == b.year && a.month == b.month && a.day == b.day;
//   }
// }
