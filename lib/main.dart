import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/service/csv/csv_parser.dart';
import 'package:kidventory_flutter/core/data/service/csv/participant_csv_parser.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service_impl.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/auth/sign_up/sign_up_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<AuthApiService>(create: (_) => AuthApiServiceImpl()),
      Provider<CSVParser>(create: (_) => ParticipantCSVParser()),
      ChangeNotifierProvider<SignInScreenViewModel>(
        create: (context) => SignInScreenViewModel(
          Provider.of<AuthApiService>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<SignUpScreenViewModel>(
        create: (context) => SignUpScreenViewModel(
          Provider.of<AuthApiService>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<EditEventScreenViewModel>(
        create: (context) => EditEventScreenViewModel(
          Provider.of<CSVParser>(context, listen: false),
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 28, 176, 245)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const AppScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class AppScreen extends StatefulWidget {
  const AppScreen({super.key, required this.title});

  final String title;

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return const MainScreen();
    // RepeatScreen();
    // MainScreen();
    // ChangePasswordScreen();
    // SignInScreen();
    // ProfileScreen();
  }
}
