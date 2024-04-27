import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/service/csv/csv_parser.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager.dart';
import 'package:kidventory_flutter/di/app_module.dart';
import 'package:kidventory_flutter/feature/auth/forgot_password/forgot_password_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/auth/sign_up/sign_up_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/events/events_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/home/home_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/main_screen.dart';
import 'package:kidventory_flutter/feature/main/profile/profile_screen_viewmodel.dart';
import 'package:kidventory_flutter/main_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MainViewModel>(
        create: (context) => MainViewModel(getIt<TokenPreferencesManager>()),
      ),
      ChangeNotifierProvider<SignInScreenViewModel>(
        create: (context) => SignInScreenViewModel(
          getIt<AuthApiService>(),
          getIt<TokenPreferencesManager>(),
        ),
      ),
      ChangeNotifierProvider<ProfileScreenViewModel>(
        create: (context) => ProfileScreenViewModel(
          getIt<UserApiService>(),
          getIt<TokenPreferencesManager>(),
        ),
      ),
      ChangeNotifierProvider<ForgotPasswordScreenViewModel>(
        create: (context) => ForgotPasswordScreenViewModel(
          getIt<AuthApiService>(),
          getIt<TokenPreferencesManager>(),
        ),
      ),
      ChangeNotifierProvider<SignUpScreenViewModel>(
        create: (context) => SignUpScreenViewModel(
          getIt<AuthApiService>(),
          getIt<TokenPreferencesManager>(),
        ),
      ),
      ChangeNotifierProvider<HomeScreenViewModel>(
        create: (context) => HomeScreenViewModel(getIt<UserApiService>()),
      ),
      ChangeNotifierProvider<EventsScreenViewModel>(
        create: (context) => EventsScreenViewModel(getIt<UserApiService>()),
      ),
      ChangeNotifierProvider<EditEventScreenViewModel>(
        create: (context) => EditEventScreenViewModel(
          getIt<CSVParser>(),
          getIt<EventApiService>(),
        ),
      ),
      ChangeNotifierProvider<EventScreenViewModel>(
        create: (context) => EventScreenViewModel(getIt<EventApiService>()),
      ),
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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 28, 176, 245)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(future: setup(), builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const AppScreen(title: 'Kidventory');
        }
        return const Center(child: CircularProgressIndicator());
      }),
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
    return Consumer<MainViewModel>(
      builder: (context, model, child) {
        if (model.isLoading) {
          return const Center(
              child: CircularProgressIndicator()); // Show loading indicator
        } else if (model.isAuthenticated) {
          return const MainScreen();
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}
