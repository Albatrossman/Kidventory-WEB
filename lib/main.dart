import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kidventory_flutter/core/data/service/csv/csv_parser.dart';
import 'package:kidventory_flutter/core/data/service/csv/participant_csv_parser.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service_impl.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service_impl.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service_impl.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager_impl.dart';
import 'package:kidventory_flutter/core/data/util/dio_client.dart';
import 'package:kidventory_flutter/di/app_,module.dart';
import 'package:kidventory_flutter/feature/auth/forgot_password/forgot_password_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/auth/sign_up/sign_up_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/events/events_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/home/home_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/main_screen.dart';
import 'package:kidventory_flutter/main_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(MultiProvider(
    providers: [
      Provider<FlutterSecureStorage>(create: (_) => const FlutterSecureStorage()),
      Provider<AuthApiService>(create: (_) => AuthApiServiceImpl(getIt<DioClient>())),
      Provider<UserApiService>(create: (_) => UserApiServiceImpl(getIt<DioClient>())),
      Provider<EventApiService>(create: (_) => EventApiServiceImpl(getIt<DioClient>())),
      Provider<CSVParser>(create: (_) => ParticipantCSVParser()),
      Provider<TokenPreferencesManager>(
        create: (context) => TokenPreferencesManagerImpl(
          storage: Provider.of<FlutterSecureStorage>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<MainViewModel>(
        create: (context) => MainViewModel(
            Provider.of<TokenPreferencesManager>(context, listen: false)),
      ),
      ChangeNotifierProvider<SignInScreenViewModel>(
        create: (context) => SignInScreenViewModel(
          Provider.of<AuthApiService>(context, listen: false),
          Provider.of<TokenPreferencesManager>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<ForgotPasswordScreenViewModel>(
        create: (context) => ForgotPasswordScreenViewModel(
          Provider.of<AuthApiService>(context, listen: false),
          Provider.of<TokenPreferencesManager>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<SignUpScreenViewModel>(
        create: (context) => SignUpScreenViewModel(
          Provider.of<AuthApiService>(context, listen: false),
          Provider.of<TokenPreferencesManager>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<HomeScreenViewModel>(
        create: (context) => HomeScreenViewModel(
          Provider.of<UserApiService>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<EventsScreenViewModel>(
        create: (context) => EventsScreenViewModel(
          Provider.of<UserApiService>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<EditEventScreenViewModel>(
        create: (context) => EditEventScreenViewModel(
          Provider.of<CSVParser>(context, listen: false),
          Provider.of<EventApiService>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<EventScreenViewModel>(
        create: (context) => EventScreenViewModel(
          Provider.of<EventApiService>(context, listen: false),
        ),
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
      home: const AppScreen(title: 'Kidventory'),
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
