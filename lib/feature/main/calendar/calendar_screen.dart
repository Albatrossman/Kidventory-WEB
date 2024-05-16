import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';
import 'package:kidventory_flutter/core/data/model/session_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/core/domain/model/color.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/util/extension/color_extension.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/di/app_module.dart';
import 'package:kidventory_flutter/feature/main/calendar/calendar_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen.dart';
import 'package:calendar_view/calendar_view.dart';

enum CalendarViewMode {
  day,
  week,
  month,
}

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
  bool loading = false;
  final EventController _calendarController = EventController();

  CalendarViewMode _calendarViewMode = CalendarViewMode.day;
  GlobalKey<DayViewState> dayViewKey = GlobalKey<DayViewState>();
  GlobalKey<WeekViewState> weekViewKey = GlobalKey<WeekViewState>();
  GlobalKey<MonthViewState> monthViewKey = GlobalKey<MonthViewState>();

  DateTime? _fetchedStartDate;
  DateTime? _fetchedEndDate;

  @override
  void initState() {
    super.initState();
    _viewModel = CalendarScreenViewModel(getIt<UserApiService>());
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
        start
            .isAfter(_fetchedStartDate!.subtract(const Duration(seconds: 1))) &&
        end.isBefore(_fetchedEndDate!.add(const Duration(seconds: 1)))) {
      return;
    }

    setState(() {
      loading = true;
      _fetchedStartDate = start;
      _fetchedEndDate = end;
    });
    _viewModel
        .getUpcomingSessionsBetweenDates(start, end)
        .whenComplete(() => {})
        .then(
          (value) => {
            setState(
              () {
                _calendarController.removeWhere((element) => true);
                _viewModel.state.upcomingSessions.map(
                  (session) {
                    final EventColor eventColor = EventColor.values.firstWhere(
                      (e) => e.name == session.color.toLowerCase(),
                    );
                    final bool isAllDay = session.timeMode == 'AllDay';

                    final event = CalendarEventData(
                      title: session.title,
                      titleStyle:
                          Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: eventColor.getReadableTextColor(),
                              ),
                      date: session.startDateTime.toLocal(),
                      startTime:
                          isAllDay ? null : session.startDateTime.toLocal(),
                      endTime: isAllDay ? null : session.endDateTime.toLocal(),
                      event: session,
                      color: eventColor.value,
                    );

                    _calendarController.add(event);
                  },
                ).toList();
                loading = false;
              },
            )
          },
          onError: (error) => {
            setState(() {
              loading = true;
            }),
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
              child: Stack(
                children: [
                  SizedBox(
                    width: 1000,
                    child: CalendarControllerProvider(
                      controller: _calendarController,
                      child: switch (_calendarViewMode) {
                        CalendarViewMode.day => DayView(
                            key: dayViewKey,
                            onEventTap: (events, date) {
                              if (events.isNotEmpty) {
                                final session =
                                    events.first.event as SessionDto;
                                push(EventScreen(
                                  id: session.eventId,
                                  role: session.role ?? RoleDto.participant,
                                ));
                              }
                            },
                            headerStyle: HeaderStyle(
                              decoration: headerBoxDecoration(context),
                            ),
                            dateStringBuilder: (date, {secondaryDate}) {
                              return date.formatDate();
                            },
                            startDuration:
                                Duration(hours: TimeOfDay.now().hour),
                            heightPerMinute: 1,
                            onPageChange: (date, page) {
                              //TODO: Arman bia kir bokhor; moft khor
                              debugPrint(
                                  "date: ${date.formatDate()} - page: $page");
                              fetchAndUpdateSessions(date.firstDayOfMonth,
                                  date.lastDayOfMonth.atEndOfDay);
                            },
                          ),
                        CalendarViewMode.week => WeekView(
                            key: weekViewKey,
                            onEventTap: (events, date) {
                              if (events.isNotEmpty) {
                                final session =
                                    events.first.event as SessionDto;
                                push(EventScreen(
                                    id: session.eventId,
                                    role: session.role ?? RoleDto.participant));
                              }
                            },
                            onDateTap: (date) {},
                            weekNumberBuilder: (firstDayOfWeek) {
                              return null;
                            },
                            headerStyle: HeaderStyle(
                              decoration: headerBoxDecoration(context),
                            ),
                            headerStringBuilder: (date, {secondaryDate}) {
                              return "${date.formatDate(useShortFormat: true)} - ${secondaryDate?.formatDate(useShortFormat: true)}";
                            },
                            onPageChange: (date, page) {
                              debugPrint(
                                  "date: ${date.formatDate()} - page: $page");
                              fetchAndUpdateSessions(date.firstDayOfMonth,
                                  date.lastDayOfMonth.atEndOfDay);
                            },
                          ),
                        CalendarViewMode.month => MonthView(
                            key: monthViewKey,
                            onEventTap: (event, date) {
                              final session = event.event as SessionDto;
                              push(EventScreen(
                                  id: session.eventId,
                                  role: session.role ?? RoleDto.participant));
                            },
                            onCellTap: (events, date) {
                              setState(() {
                                _calendarViewMode = CalendarViewMode.day;
                              });
                              Future.delayed(const Duration(milliseconds: 50),
                                  () {
                                dayViewKey.currentState?.jumpToDate(date);
                              });
                            },
                            headerStyle: HeaderStyle(
                              decoration: headerBoxDecoration(context),
                            ),
                            headerStringBuilder: (date, {secondaryDate}) {
                              return DateFormat.yMMMMd().format(date.toLocal());
                            },
                            onPageChange: (date, page) {
                              debugPrint(
                                  "date: ${date.formatDate()} - page: $page");
                              fetchAndUpdateSessions(
                                  date, date.lastDayOfMonth.atEndOfDay);
                            },
                            useAvailableVerticalSpace: false,
                          ),
                      },
                    ),
                  ),
                  _buildLoadingOverlay()
                ],
              ),
            ),
          ],
        ),
    );
  }

  Widget viewSwitcher(BuildContext context) {
    return SizedBox(width: 1000, child: 
    Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CupertinoSlidingSegmentedControl<CalendarViewMode>(
            // selectedColor: Theme.of(context).colorScheme.primary,
            // borderColor: Theme.of(context).colorScheme.primary,
            thumbColor: Theme.of(context).colorScheme.primaryContainer,
            groupValue: _calendarViewMode,
            onValueChanged: (CalendarViewMode? value) {
              setState(() {
                _calendarViewMode = value ?? CalendarViewMode.day;
              });
            },
            children: const <CalendarViewMode, Widget>{
              CalendarViewMode.day: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Day",
                  // style: Theme.of(context).textTheme.labelLarge?.copyWith(),
                ),
              ),
              CalendarViewMode.week: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Week",
                    // style: Theme.of(context).textTheme.labelLarge?.copyWith(),
                  )),
              CalendarViewMode.month: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Month",
                    // style: Theme.of(context).textTheme.labelLarge?.copyWith(),
                  )),
            },
          ),
        ),
        const Spacer(),
        CupertinoButton(
          child: Icon(
            CupertinoIcons.calendar_today,
            size: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () => {
            if (_calendarViewMode == CalendarViewMode.day)
              dayViewKey.currentState?.animateToDate(DateTime.now()),
            if (_calendarViewMode == CalendarViewMode.week)
              weekViewKey.currentState?.animateToWeek(DateTime.now()),
            if (_calendarViewMode == CalendarViewMode.month)
              monthViewKey.currentState?.animateToMonth(DateTime.now())
          },
        )
      ],
    )
    ); 
  }

  BoxDecoration headerBoxDecoration(BuildContext context) {
    return BoxDecoration(
      // color: Theme.of(context).colorScheme.primaryContainer,
      border: kIsWeb ? null : Border.all(
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
      borderRadius: kIsWeb ? BorderRadius.zero : const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return loading
        ? Positioned.fill(
            child: Container(
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
          )
        : const SizedBox.shrink();
  }
}
