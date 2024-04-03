import 'package:flutter/material.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen.dart';
import 'package:kidventory_flutter/feature/auth/sign_up/sign_up_screen.dart';

import 'feature/main/calendar/calendar_screen.dart';
import 'feature/main/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;

  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget contentWidget;
    switch (_currentIndex) {
      case 0:
        contentWidget = HomeScreen(
          onManageEventsClick: () => {},
          onCreateEventClick: () => {},
        );
        break;
      case 1:
        contentWidget = const CalendarScreen();
        break;
      case 2:
        contentWidget = Center(
          child: Text(
            'Profile Page',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        );
        break;
      default:
        contentWidget = Center(
          child: Text(
            'Select a tab',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        );
    }

    return const SignInScreen();
    // Scaffold(
    //   body: contentWidget,
    //   bottomNavigationBar: BottomNavigationBar(
    //     items: const <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home),
    //         label: 'Home',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.date_range_rounded),
    //         label: 'Calendar',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.person),
    //         label: 'Profile',
    //       ),
    //     ],
    //     currentIndex: _currentIndex,
    //     onTap: _onItemTapped,
    //   ).asGlass(),
    // );
  }
}