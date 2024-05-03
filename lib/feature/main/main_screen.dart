import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/di/app_module.dart';
import 'package:kidventory_flutter/feature/main/calendar/calendar_screen.dart';
import 'package:kidventory_flutter/feature/main/calendar/mit_calendar_screen.dart';
import 'package:kidventory_flutter/feature/main/home/home_screen.dart';
import 'package:kidventory_flutter/feature/main/join%20event/join_event_screen.dart';
import 'package:kidventory_flutter/feature/main/main_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/profile/profile_screen.dart';
import 'package:kidventory_flutter/main.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen>
    with MessageMixin, NavigationMixin, RouteAware, WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final MainScreenViewModel _viewModel;
  bool isLoading = false;

  int _currentIndex = 0;
  late bool showNavigationDrawer = false;
  late bool showFullDrawer = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _viewModel = MainScreenViewModel(
        getIt<EventApiService>(), getIt<TokenPreferencesManager>());
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkInviteLink();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didPush() {
    _checkInviteLink();
    super.didPush();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainScreenViewModel>.value(
      value: _viewModel,
      child: Consumer<MainScreenViewModel>(
        builder: (context, model, child) {
          return Stack(
            children: [
              showNavigationDrawer
                  ? buildDrawerScaffold(context)
                  : buildBottomBarScaffold(),
              if (_viewModel.state.loading)
                Container(
                  width: double.infinity,
                  height: double.infinity,
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
            ],
          );
        },
      ),
    );
  }

  void _openDrawer() {
    setState(() {
      showFullDrawer = !showFullDrawer;
    });
  }

  Widget contentWidget() {
    switch (_currentIndex) {
      case 0:
        return HomeScreen(
          onManageEventsClick: () => {},
          onCreateEventClick: () => {},
        );
      case 1:
        return const MitCalendarScreen();
      case 2:
        return const ProfileScreen();
      default:
        return Center(
          child: Text(
            'Select a tab',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        );
    }
  }

  Widget buildBottomBarScaffold() {
    return Scaffold(
      body: contentWidget(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: destinations.map(
          (DestinationModel destination) {
            return NavigationDestination(
              label: destination.label,
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
              tooltip: destination.label,
            );
          },
        ).toList(),
      ),
    );
  }

  Widget buildDrawerScaffold(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        bottom: false,
        top: false,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: NavigationRail(
                elevation: 4,
                minWidth: 72,
                minExtendedWidth: 172,
                extended: showFullDrawer,
                labelType: NavigationRailLabelType.none,
                backgroundColor: Theme.of(context).colorScheme.surface,
                leading: navigationRailLeadingContent(),
                destinations: destinations.map(
                  (DestinationModel destination) {
                    return NavigationRailDestination(
                      label: Text(
                        destination.label,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w500),
                      ),
                      icon: destination.icon,
                      selectedIcon: destination.selectedIcon,
                    );
                  },
                ).toList(),
                selectedIndex: _currentIndex,
                useIndicator: true,
                onDestinationSelected: (int index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: contentWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget navigationRailLeadingContent() {
    return SizedBox(
      width: showFullDrawer ? 156 : 56,
      child: IconButton(
        onPressed: _openDrawer,
        alignment: showFullDrawer ? Alignment.centerLeft : Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        icon: Icon(
            showFullDrawer ? CupertinoIcons.xmark : CupertinoIcons.list_bullet),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
    showNavigationDrawer = MediaQuery.of(context).size.width >= 450;
    showFullDrawer = MediaQuery.of(context).size.width >= 650;
  }

  void _checkInviteLink() {
    if (inviteLinkReferenceId != null && !_viewModel.state.loading) {
      _viewModel.getEventFrom(inviteLinkReferenceId!).whenComplete(() {
        inviteLinkReferenceId = null;
      }).then(
        (value) => pushSheet(JoinEventScreen(
          invitedEventDto: value,
        )),
        onError: (error) => {
          snackbar((error as DioException).message ?? "Something went wrong")
        },
      );
    }
  }
}

class DestinationModel {
  const DestinationModel(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<DestinationModel> destinations = <DestinationModel>[
  DestinationModel(
      'Home', Icon(CupertinoIcons.house), Icon(CupertinoIcons.house)),
  DestinationModel(
      'Calendar', Icon(CupertinoIcons.calendar), Icon(CupertinoIcons.calendar)),
  DestinationModel(
      'Profile', Icon(CupertinoIcons.person), Icon(CupertinoIcons.person)),
];
