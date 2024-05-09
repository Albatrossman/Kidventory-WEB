import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/core/ui/component/event_card.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/di/app_module.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen.dart';
import 'package:kidventory_flutter/feature/main/events/events_screen_viewmodel.dart';
import 'package:kidventory_flutter/main.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EventsScreenState();
  }
}

class _EventsScreenState extends State<EventsScreen>
    with MessageMixin, NavigationMixin, RouteAware {
  late final EventsScreenViewModel _viewModel;
  String _searchQuery = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void initState() {
    _viewModel = EventsScreenViewModel(getIt<UserApiService>());
    super.initState();
    _viewModel.getEvents().onError((error, stackTrace) {
      String message = 'Something went wrong';
      if (error is DioException) {
        message = error.message ?? message;
      }

      snackbar(message);
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _viewModel.getEvents();
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventsScreenViewModel>.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => pop(),
            icon: const Icon(CupertinoIcons.back),
          ),
          title: const Text('Manage Events'),
          centerTitle: true,
        ),
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                searchBar(context),
                const SizedBox(height: 16),
                const Divider(height: 2),
                eventsList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SearchBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(CupertinoIcons.search),
        ),
        hintText: 'Search events',
        elevation: const MaterialStatePropertyAll(1),
        onChanged: (text) {
          setState(() {
            _searchQuery = text;
          });
        },
      ),
    );
  }

  Widget eventsList(BuildContext context) {
    return Consumer<EventsScreenViewModel>(
      builder: (context, model, child) {
        final List<EventDto> events = model.state.events
            .where((event) => event.name.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();
        if (model.state.loading) {
          return loadingView(context);
        } else if (model.state.events.isEmpty) {
          return emptyView(context, "You have not created any events");
        } else if (events.isEmpty) {
          return emptyView(
              context, "No events containing the \"$_searchQuery\" were found");
        } else {
          return Expanded(
            child: SizedBox(
              width: 800,
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final EventDto event = events[index];
                  return EventCard(
                    name: event.name,
                    time:
                        "${DateFormat.jm().format(event.repeat.startDateTime.toLocal())} - ${DateFormat.jm().format(event.repeat.endDateTime.toLocal())}",
                    onClick: () => {push(EventScreen(id: event.id))},
                    imageUrl: event.imageUrl,
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  Widget loadingView(BuildContext context) {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget emptyView(BuildContext context, String text) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.doc_text_search,
              size: 48,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
