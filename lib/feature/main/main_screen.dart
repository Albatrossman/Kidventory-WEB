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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  int _currentIndex = 0;
  late bool showNavigationDrawer = false;
  late bool showFullDrawer = false;

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
        return const CalendarScreen();
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
            showFullDrawer ? CupertinoIcons.xmark : CupertinoIcons.list_bullet
            ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 450;
    showFullDrawer = MediaQuery.of(context).size.width >= 650;
  }

  @override
  Widget build(BuildContext context) {
    return showNavigationDrawer
        ? buildDrawerScaffold(context)
        : buildBottomBarScaffold();
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
