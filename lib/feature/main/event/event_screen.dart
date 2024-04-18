import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kidventory_flutter/core/ui/component/participant_row.dart';
import 'package:kidventory_flutter/core/ui/util/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/navigation_mixin.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EventScreenState();
  }
}

class _EventScreenState extends State<EventScreen> with MessageMixin, NavigationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () => pop(),
              icon: const Icon(CupertinoIcons.back),
            ),
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Event',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              background: const FittedBox(
                fit: BoxFit.cover,
                child: Image(
                  image: NetworkImage('https://www.responsiveclassroom.org/wp-content/uploads/2016/04/DSC_2388-1024x682.jpg'),
                ),
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                onSelected: (String result) {
                  switch (result) {
                    case 'Invite members':
                      break;
                    case 'Edit':
                      break;
                    case 'Delete':
                      break;
                    default:
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Invite members',
                    child: Text('Invite members'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Edit',
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Delete',
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
            pinned: true,
            snap: false,
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => {},
                  child: const Text('Take Attendance'),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ParticipantRow(
                  avatarUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRadDlQU2JAgnWtWITD4JYn6Gudy8b0LIhL-tohNNsvWw&s',
                  name: 'Pouya Rezaei',
                  onClick: () => {},
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
