import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/ui/component/event_card.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen.dart';
import 'package:kidventory_flutter/feature/main/events/events_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EventsScreenState();
  }
}

class _EventsScreenState extends State<EventsScreen>
    with MessageMixin, NavigationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => pop(),
          icon: const Icon(CupertinoIcons.back),
        ),
        title: const Text('Manage Events'),
        centerTitle: true,
      ),
      body: SafeArea(
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
    );
  }

  Widget searchBar(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SearchBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(CupertinoIcons.search),
        ),
        hintText: 'Search events',
        elevation: MaterialStatePropertyAll(1),
      ),
    );
  }

  Widget eventsList(BuildContext context) {
    return Consumer<EventsScreenViewModel>(
      builder: (context, model, child) {
        if (model.state.loading) {
          return loadingView(context);
        } else if (model.state.events.isEmpty) {
          return emptyView(context);
        } else {
          return Expanded(
            child: SizedBox(
              width: 800,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: model.state.events.length,
                itemBuilder: (context, index) {
                  final EventDto event = model.state.events[index];
                  return EventCard(
                    name: event.title,
                    time: "${event.startTime} - ${event.endTime}",
                    onClick: () => {push(const EventScreen())},
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

  Widget emptyView(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.doc_text_search,
              size: 48,
            ),
            SizedBox(height: 16),
            Text(
              "You have not created any events",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
