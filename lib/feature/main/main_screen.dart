import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/feature/main/calendar/calendar_screen.dart';
import 'package:kidventory_flutter/feature/main/home/home_screen.dart';
import 'package:kidventory_flutter/feature/main/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
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
        contentWidget = const ProfileScreen();
        break;
      default:
        contentWidget = Center(
          child: Text(
            'Select a tab',
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium,
          ),
        );
    }

    return Scaffold(
      body: contentWidget,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}