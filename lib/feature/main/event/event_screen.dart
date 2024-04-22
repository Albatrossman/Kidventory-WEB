import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/component/participant_row.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/feature/main/attendance/attendance_screen.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EventScreenState();
  }
}

class _EventScreenState extends State<EventScreen>
    with MessageMixin, NavigationMixin {
  bool isLoading = false;
  List<String> members = [
    "test",
    "test",
    "test",
    "test",
    "test",
    "test",
    "test"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(context),
        actions: [
          optionsButton(context),
          const SizedBox(
            width: 8,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              eventHeader(context),
              const SizedBox(height: 16),
              sessionOption(context),
              const SizedBox(height: 16),
              attendanceButton(context),
              membersList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget backButton(BuildContext context) {
    return IconButton(
      onPressed: () => pop(),
      icon: const Icon(CupertinoIcons.back),
    );
  }

  Widget optionsButton(BuildContext context) {
    return PopupMenuButton<String>(
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
    );
  }

  Widget eventHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: const Image(
            height: 100,
            width: 100,
            fit: BoxFit.fill,
            image: NetworkImage(
                'https://www.responsiveclassroom.org/wp-content/uploads/2016/04/DSC_2388-1024x682.jpg'),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Name',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            Text(
              'Event By Baroody Camps',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget sessionOption(BuildContext context) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  DateTime.now().formatDate(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const Spacer(),
                Text(
                  "11:00 AM - 12:30 PM",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ],
            ),
          ),
          const Divider(height: 4),
          CupertinoButton(
            onPressed: () => {},
            padding: const EdgeInsets.all(16),
            child: Text(
              'Change Session',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          )
        ],
      ),
    );
  }

  Widget attendanceButton(BuildContext context) {
    return SizedBox(
      height: kIsWeb ? 40 : 40,
      width: double.infinity,
      child: FilledButton(
        onPressed: () => pushSheet(const AttendanceScreen()),
        style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => Theme.of(context).colorScheme.primaryContainer)),
        child: Text(
          'Take Attendance',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
    );
  }

  Widget membersList(BuildContext context) {
    return Column(
      children: [
        participantsSection(context),
      ],
    );
  }

  Widget participantsSection(BuildContext context) {
    if (members.isEmpty) {
      return const SizedBox(width: 0);
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionHeader("Members", context),
          Column(
            children: List.generate(
              members.length,
              (index) {
                return ParticipantRow(
                  avatarUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRadDlQU2JAgnWtWITD4JYn6Gudy8b0LIhL-tohNNsvWw&s',
                  name: 'Pouya Rezaei',
                  onClick: () => {},
                );
              },
            ),
          )
        ],
      );
    }
  }

  Widget sectionHeader(String title, BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Text("Members"),
    );
  }
}
