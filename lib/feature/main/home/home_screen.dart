import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/component/session_card.dart';
import 'package:kidventory_flutter/core/ui/util/navigation_mixin.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen.dart';
import 'package:kidventory_flutter/feature/main/events/events_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onManageEventsClick;
  final VoidCallback onCreateEventClick;

  const HomeScreen({
    super.key,
    required this.onManageEventsClick,
    required this.onCreateEventClick,
  });

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with NavigationMixin {
  bool isLoading = false;
  List<Session> upcomingSessions = [];

  @override
  void initState() {
    super.initState();
    loadSessions();
  }

  void loadSessions() async {
    setState(() {
      isLoading = true;
    });
    try {
      upcomingSessions = await fetchSessions();
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                greetingsWidget(context),
                const SizedBox(height: 32.0),
                Column(
                  children: [
                    upcomingEvents(context),
                    const SizedBox(height: 32.0),
                    Row(
                      children: [
                        manageEventsButton(context),
                        const SizedBox(width: 16),
                        createEventButton(context),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget greetingsWidget(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
              width: 1.0,
            ),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage("https://i.pravatar.cc/150?img=3"),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "greeting",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    "Pouya Rezaei",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Text(
                "21 Feb, 2024",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget upcomingEvents(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upcoming Events",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 16.0),
        Column(
          children: List.generate(
              upcomingSessions.isEmpty ? 1 : upcomingSessions.length, (index) {
            if (isLoading) {
              return Container(
                width: double.infinity,
                height: 166,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                // child: const SizedBox(
                //   width: 40,
                //   height: 40,
                //   child: CircularProgressIndicator(),
                // ),
              );
            } else {
              if (upcomingSessions.isEmpty) {
                return Container(
                  width: double.infinity,
                  height: 160,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text("You have no upcoming events"),
                );
              } else {
                return SessionCard(
                  session: upcomingSessions[index],
                  onClick: () => push(const EventScreen()),
                );
              }
            }
          }),
        ),
      ],
    );
  }

  Widget manageEventsButton(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          push(const EventsScreen());
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Icon(CupertinoIcons.square_list),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Manage Events',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Text(
                '3 events',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createEventButton(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          push(const EditEventScreen());
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Icon(CupertinoIcons.add),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Create Event',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Text(
                'Create a new event',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<Session>> fetchSessions() async {
  String now = DateTime.now().toUtc().toIso8601String();

  final response = await http.get(
    Uri.parse(
            'https://kidventory.aftersearch.com/api/parent/getUpcomingSessions')
        .replace(queryParameters: {'datetime': now}),
    headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJ1c2VySWQiOiI2NGNmNWYwYjZkNjY5M2NiMmE1Y2QxZjQiLCJpc1N1YnNjcmliZSI6IkZhbHNlIiwic3ViIjoiYWJiYXNiYXZhcnNhZEBnbWFpbC5jb20iLCJ0eXBlIjoiVXNlciIsInJvbGVzIjoiIiwibmJmIjoxNzEyNjI3MzE3LCJleHAiOjE3MTM0OTEzMTcsImlhdCI6MTcxMjYyNzMxNywiaXNzIjoiaHR0cDovL2tpZHZudG9yeWlkZW50aXR5LmFmdGVyc2VhcmNoLmNvbSIsImF1ZCI6IkIwYjVlOGR5eXBKQWQ1WThCYUg4RVpsSVZqWjEvR3NlVzdzR0NkQ0hoSk09In0.YFz-RSvue-846k1mIFzt-n92Vp1wK5q8xi6nR8BXL2E',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((session) => Session.fromJson(session)).toList();
  } else {
    throw Exception('Failed to load sessions from API');
  }
}
