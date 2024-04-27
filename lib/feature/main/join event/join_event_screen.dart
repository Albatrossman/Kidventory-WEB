import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/ui/component/event_card.dart';
import 'package:kidventory_flutter/core/ui/component/sheet_header.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen.dart';
import 'package:kidventory_flutter/feature/main/join%20event/join_event_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class JoinEventScreen extends StatefulWidget {
  const JoinEventScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _JoinEventScreenState();
  }
}

class _JoinEventScreenState extends State<JoinEventScreen>
    with MessageMixin, NavigationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SheetHeader(title: Text("Join Event")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              header(context),
              const SizedBox(height: 16),
              const Divider(height: 2),
              eventsList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text("Event name"),
          Row(
            children: [
              Text("11:00 am - 12:00 pm"),
            ],
          ),
        ],
      ),
    );
  }

  Widget eventsList(BuildContext context) {
    return Consumer<JoinEventScreenViewModel>(
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
                    name: event.name,
                    time: "${event.startTime} - ${event.endTime}",
                    onClick: () => {  },
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
