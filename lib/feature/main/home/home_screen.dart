import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/ui/component/session_card.dart';

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

class _HomeScreenState extends State<HomeScreen> {
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
    } catch (e) {
      print('Failed to load sessions: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
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
          ),
          const SizedBox(height: 32.0),
          Column(
            children: [
              Column(
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
                    children: List.generate(3, (index) {
                      if (isLoading) {
                        return Container(
                          width: double.infinity,
                          height: 88,
                          color: Colors.grey.shade300,
                        );
                      } else {
                        return SessionCard(
                          session: upcomingSessions[index],
                          onClick: () {},
                        );
                      }
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Handle manage events click
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.date_range),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Manage Events',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium,
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
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Handle create event click
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.add),
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
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<List<Session>> fetchSessions() async {
  String now = DateTime.now().toUtc().toIso8601String();

  final response = await http.get(
    Uri.parse('https://dev-kidsapi.softballforce.com/api/parent/getUpcomingSessions').replace(queryParameters: {'datetime': now}),
    headers: {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJ1c2VySWQiOiI2NGNmNWYwYjZkNjY5M2NiMmE1Y2QxZjQiLCJpc1N1YnNjcmliZSI6IkZhbHNlIiwic3ViIjoiYWJiYXNiYXZhcnNhZEBnbWFpbC5jb20iLCJ0eXBlIjoiVXNlciIsInJvbGVzIjoiIiwibmJmIjoxNzA4NDcxMzkzLCJleHAiOjE3MDkzMzUzOTIsImlhdCI6MTcwODQ3MTM5MywiaXNzIjoiaHR0cHM6Ly9kZXYta2lkc2lkZW50aXR5LnNvZnRiYWxsZm9yY2UuY29tIiwiYXVkIjoiQjBiNWU4ZHl5cEpBZDVZOEJhSDhFWmxJVmpaMS9Hc2VXN3NHQ2RDSGhKTT0ifQ.SkLmZSfj315l8elCe0y4r0tLFww_kMqt07V9kz510kQ',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    print("response $jsonResponse");
    return jsonResponse.map((session) => Session.fromJson(session)).toList();
  } else {
    throw Exception('Failed to load sessions from API');
  }
}
