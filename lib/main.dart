import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/model/profile_dto.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/di/app_module.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen.dart';
import 'package:kidventory_flutter/feature/main/main_screen.dart';
import 'package:kidventory_flutter/main_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MainViewModel>(
        create: (context) => MainViewModel(getIt<TokenPreferencesManager>()),
      ),
    ],
    child: const MyApp(),
  ));
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
String? inviteLinkReferenceId;
ProfileDto? globalUserProfile;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kidventory',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 28, 176, 245)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
      home: FutureBuilder(
          future: setup(),
          builder: (context, snapshot) {
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

class _AppScreenState extends State<AppScreen> with NavigationMixin {
  bool isLoading = false;
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Check initial link if app was in cold state (terminated)
    final appLink = await _appLinks.getInitialAppLink();
    if (appLink != null) {
      openAppLink(appLink);
    }

    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    String? id = uri.queryParameters['id'];
    inviteLinkReferenceId = id;
    // pushSheet(const JoinEventScreen());
  }

  @override
  void initState() {
    super.initState();
    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, model, child) {
        if (model.isLoading) {
          return const Center(child: CircularProgressIndicator()); // Show loading indicator
        } else if (model.isAuthenticated) {
          return const MainScreen();
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}
