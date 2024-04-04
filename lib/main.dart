import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service_impl.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen.dart';
import 'package:kidventory_flutter/feature/auth/sign_up/sign_up_screen.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen_viewmodel.dart';
import 'package:provider/provider.dart';

import 'feature/main/calendar/calendar_screen.dart';
import 'feature/main/home/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<AuthApiService>(create: (_) => AuthApiServiceImpl()),
      ChangeNotifierProvider<SignInScreenViewModel>(
        create: (context) => SignInScreenViewModel(
          Provider.of<AuthApiService>(context, listen: false),
        ),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 28, 176, 245)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
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
