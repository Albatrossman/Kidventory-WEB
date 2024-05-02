import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/model/participant_dto.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/component/participant_row.dart';
import 'package:kidventory_flutter/core/ui/util/extension/string_extension.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/feature/main/attendance/attendance_screen.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/invite_members/invite_members_screen.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key, required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() {
    return _EventScreenState();
  }
}

class _EventScreenState extends State<EventScreen> with MessageMixin, NavigationMixin {
  late final EventScreenViewModel _viewModel;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<EventScreenViewModel>(context, listen: false);
    _viewModel.refresh(widget.id).then(
      (value) => {},
      onError: (error) => snackbar((error as DioException).message ?? "Something went wrong"),
    );
  }

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
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
          child: Column(
            children: [
              const SizedBox(height: 16),
              eventHeader(context),
              const SizedBox(height: 16),
              sessionOption(context),
              const SizedBox(height: 16),
              attendanceButton(
                context,
                _viewModel.state.event?.id ?? "",
                _viewModel.state.event?.nearestSession.id ?? "",
              ),
              Consumer<EventScreenViewModel>(
                builder: (_, model, __) {
                  return membersList(context, model.state.participantsByRole ?? {});
                },
              ),
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
            pushSheet(const InviteMembersScreen());
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
            Consumer<EventScreenViewModel>(builder: (context, model, child) {
              return Text(
                model.state.event?.name ?? '',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              );
            }),
            // Text(
            //   'Event By Baroody Camps',
            //   style: Theme.of(context).textTheme.titleSmall?.copyWith(
            //         color: Theme.of(context).colorScheme.primary,
            //       ),
            // ),
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
                ),
                const Spacer(),
                Text(
                  "11:00 AM - 12:30 PM",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
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

  Widget attendanceButton(BuildContext context, String eventId, String sessionId) {
    return SizedBox(
      height: kIsWeb ? 40 : 40,
      width: double.infinity,
      child: FilledButton(
        onPressed: () => pushSheet(AttendanceScreen(eventId: eventId, sessionId: sessionId)),
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

  Widget membersList(BuildContext context, Map<RoleDto, List<ParticipantDto>> participantsByRole) {
    List<Widget> sections = [];
    participantsByRole.forEach((role, participants) {
      sections.add(participantsSection(context, role.name.capitalize(), participants));
    });

    return Column(children: sections);
  }

  Widget participantsSection(
    BuildContext context,
    String label,
    List<ParticipantDto> participants,
  ) {
    if (participants.isEmpty) {
      return const SizedBox(width: 0);
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionHeader(label, context),
          Column(
            children: List.generate(
              participants.length,
              (index) {
                ParticipantDto participant = participants[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ParticipantRow(
                    avatarUrl: participant.avatarUrl,
                    name: "${participant.firstName} ${participant.lastName}",
                    onClick: () => {},
                  ),
                );
              },
            ),
          )
        ],
      );
    }
  }

  Widget sectionHeader(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Text(title),
    );
  }
}
