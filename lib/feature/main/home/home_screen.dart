import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/model/session_dto.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/component/session_card.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/feature/main/edit_event/edit_event_screen.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen.dart';
import 'package:kidventory_flutter/feature/main/events/events_screen.dart';
import 'package:kidventory_flutter/feature/main/home/home_screen_viewmodel.dart';
import 'package:provider/provider.dart';

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

class _HomeScreenState extends State<HomeScreen>
    with NavigationMixin, RouteAware {
  late final HomeScreenViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Consumer<HomeScreenViewModel>(
                  builder: (_, model, __) {
                    return greetingsWidget(context);
                  },
                ),
                const SizedBox(height: 32.0),
                Column(
                  children: [
                    upcomingEvents(context),
                    const SizedBox(height: 32.0),
                    Row(
                      children: [
                        manageEventsButton(context),
                        const SizedBox(width: 16),
                        createEventButton(context),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget greetingsWidget(BuildContext context) {
    return Row(
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
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(_viewModel.state.profile?.avatarUrl ?? ""),
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
                    "greetings",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    "${_viewModel.state.profile?.firstName ?? ""} ${_viewModel.state.profile?.lastName ?? ""}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Text(
                DateTime.now().formatDate(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget upcomingEvents(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upcoming Events",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 16.0),
        Consumer<HomeScreenViewModel>(
          builder: (_, model, __) {
            return Column(
              children: List.generate(
                  model.state.upcomingSessions.isEmpty
                      ? 1
                      : model.state.upcomingSessions.length, (index) {
                if (model.state.loading) {
                  return Container(
                    width: double.infinity,
                    height: 166,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                } else {
                  if (model.state.upcomingSessions.isEmpty) {
                    return Container(
                      width: double.infinity,
                      height: 160,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: const Text("You have no upcoming events"),
                    );
                  } else {
                    SessionDto session = model.state.upcomingSessions[index];
                    return SessionCard(
                      session: session,
                      onClick: () => push(EventScreen(id: session.eventId)),
                    );
                  }
                }
              }),
            );
          },
        ),
      ],
    );
  }

  Widget manageEventsButton(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          push(const EventsScreen());
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Icon(CupertinoIcons.square_list),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Manage Events',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createEventButton(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          push(const EditEventScreen());
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Icon(CupertinoIcons.add),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Create Event',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
