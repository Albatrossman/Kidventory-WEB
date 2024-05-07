import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidventory_flutter/core/data/model/join_status_dto.dart';
import 'package:kidventory_flutter/core/data/model/participant_dto.dart';
import 'package:kidventory_flutter/core/data/model/pending_member_dto.dart';
import 'package:kidventory_flutter/core/data/model/pending_members_dto.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';
import 'package:kidventory_flutter/core/data/model/update_join_status_dto.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/component/card.dart';
import 'package:kidventory_flutter/core/ui/component/participant_row.dart';
import 'package:kidventory_flutter/core/ui/component/pending_member_row.dart';
import 'package:kidventory_flutter/core/ui/util/extension/string_extension.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/feature/main/attendance/attendance_screen.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/invite_members/invite_members_screen.dart';
import 'package:kidventory_flutter/feature/session_picker/session_picker.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key, required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() {
    return _EventScreenState();
  }
}

class _EventScreenState extends State<EventScreen>
    with MessageMixin, NavigationMixin {
  late final EventScreenViewModel _viewModel;

  bool isLoading = false;
  bool isDeleting = false;

  RoleDto? userRole() => _viewModel.state.participants.isEmpty
      ? null
      : _viewModel.state.participants
          .firstWhere((element) => element.role == RoleDto.owner)
          .role;

  bool canDelete() => userRole() == RoleDto.owner;

  bool canTakeAttendance() => userRole() == RoleDto.owner;

  bool canInviteMembers() =>
      userRole() == RoleDto.owner || userRole() == RoleDto.teacher;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<EventScreenViewModel>(context, listen: false);
    _viewModel.refresh(widget.id).then(
          (value) => {},
          onError: (error) => snackbar(
              (error as DioException).message ?? "Something went wrong"),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: backButton(context),
            actions: [
              optionsButton(context),
              const SizedBox(
                width: 8,
              )
            ],
          ),
          body: Consumer<EventScreenViewModel>(
            builder: (_, model, __) {
              return _viewModel.state.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            eventHeader(context),
                            const SizedBox(height: 16),
                            sessionOption(context),
                            const SizedBox(height: 16),
                            if (canTakeAttendance())
                              attendanceButton(
                                context,
                                _viewModel.state.event?.id ?? "",
                                _viewModel.state.event?.nearestSession.id ?? "",
                              ),
                            if (canDelete())
                              pendingMembersSection(
                                  context,
                                  model.state.pendingMembers.isEmpty
                                      ? []
                                      : model
                                          .state.pendingMembers.first.members),
                            membersList(
                                context, model.state.participantsByRole ?? {})
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
        if (isDeleting)
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
            deleteConfirmationDialog(_viewModel.state.event?.id ?? "");
            break;
          default:
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        if (canInviteMembers())
          const PopupMenuItem<String>(
            value: 'Invite members',
            child: Text('Invite members'),
          ),
        //TODO: add edit

        // const PopupMenuItem<String>(
        //   value: 'Edit',
        //   child: Text('Edit'),
        // ),
        if (canDelete())
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
        SizedBox(
          width: 100.0,
          height: 100.0,
          child: AppCard(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox.fromSize(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: _viewModel.state.event?.imageUrl ?? "",
                  placeholder: (context, url) => Icon(CupertinoIcons.photo,
                      color: Theme.of(context).colorScheme.primary),
                  errorWidget: (context, url, error) => Icon(
                    CupertinoIcons.photo,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
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
            child: Consumer<EventScreenViewModel>(
              builder: (context, model, child) {
                return Row(
                  children: [
                    Text(
                      model.state.selectedSession?.startDateTime.formatDate() ??
                          DateTime.now().formatDate(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    const Spacer(),
                    Text(
                      "${DateFormat.jm().format(model.state.selectedSession?.startDateTime.toLocal() ?? DateTime.now())} - ${DateFormat.jm().format(model.state.selectedSession?.endDateTime.toLocal() ?? DateTime.now())}",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ],
                );
              },
            ),
          ),
          const Divider(height: 4),
          CupertinoButton(
            onPressed: () => {
              pushSheet(
                Consumer<EventScreenViewModel>(
                    builder: (context, model, child) {
                  return SessionPicker(
                    loading: model.state.loading,
                    sessions: model.state.sessions,
                    selected: model.state.selectedSession,
                    onSessionPicked: (session) {
                      _viewModel
                          .changeSession(session)
                          .whenComplete(() => pop());
                    },
                  );
                }),
              )
            },
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

  Widget attendanceButton(
      BuildContext context, String eventId, String sessionId) {
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

  Widget membersList(BuildContext context,
      Map<RoleDto, List<ParticipantDto>> participantsByRole) {
    List<Widget> sections = [];
    participantsByRole.forEach((role, participants) {
      sections.add(
          participantsSection(context, role.name.capitalize(), participants));
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

  Widget pendingMembersSection(
    BuildContext context,
    List<PendingMemberDto> participants,
  ) {
    if (participants.isEmpty) {
      return const SizedBox(width: 0);
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionHeader("Join requests", context),
          Column(
            children: List.generate(
              participants.length,
              (index) {
                PendingMemberDto participant = participants[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: PendingMemberRow(
                    avatarUrl: "",
                    name: "${participant.firstName} ${participant.lastName}",
                    onClick: () => {},
                    onAccept: () {
                      _onUpdatePendingMember(
                        true,
                        participant.role,
                        participant.adultUserId,
                        participant.memberId,
                        participant.id,
                      );
                    },
                    onDecline: () {
                      _onUpdatePendingMember(
                        false,
                        participant.role,
                        participant.adultUserId,
                        participant.memberId,
                        participant.id,
                      );
                    },
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

  void deleteConfirmationDialog(String id) {
    dialog(
      const Text("Delete Event"),
      const Text(
          "Are you sure you want to delete this event?\n\nAll information such as participants and attendance will be lost forever."),
      [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => {Navigator.pop(context)},
          child: const Text("Cancel"),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => {_onDelete(context, id)},
          child: const Text("Delete"),
        ),
      ],
    );
  }

  void _onDelete(BuildContext context, String id) async {
    pop();
    setState(() {
      isDeleting = true;
    });
    _viewModel.deleteEvent(id).whenComplete(() => isDeleting = true).then(
          (value) => pop(),
          onError: (error) => {
            snackbar((error as DioException).message ?? "Something went wrong"),
          },
        );
  }

  void _onUpdatePendingMember(bool accept, RoleDto role, String userId,
      String memberId, String requestId) async {
    setState(() {
      isDeleting = true;
    });
    _viewModel
        .updatePendingMembers(
          UpdateJoinStatusDto(
            participantUserId: userId,
            participantMemberId: memberId,
            role: role,
            state: accept ? JoinStatusDto.accepted : JoinStatusDto.declined,
          ),
          requestId,
        )
        .whenComplete(() => isDeleting = true)
        .then(
          (value) => {},
          onError: (error) => {
            snackbar((error as DioException).message ?? "Something went wrong"),
          },
        );
  }
}
