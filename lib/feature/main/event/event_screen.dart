import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidventory_flutter/core/data/model/join_status_dto.dart';
import 'package:kidventory_flutter/core/data/model/participant_dto.dart';
import 'package:kidventory_flutter/core/data/model/pending_member_dto.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';
import 'package:kidventory_flutter/core/data/model/update_join_status_dto.dart';
import 'package:kidventory_flutter/core/data/service/csv/csv_parser.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service.dart';
import 'package:kidventory_flutter/core/data/util/downloader/downloader.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/component/card.dart';
import 'package:kidventory_flutter/core/ui/component/participant_row.dart';
import 'package:kidventory_flutter/core/ui/component/pending_member_row.dart';
import 'package:kidventory_flutter/core/ui/component/sheet_header.dart';
import 'package:kidventory_flutter/core/ui/util/extension/string_extension.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/picker_mixin.dart';
import 'package:kidventory_flutter/di/app_module.dart';
import 'package:kidventory_flutter/feature/main/attendance/attendance_screen.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/invite_members/invite_members_screen.dart';
import 'package:kidventory_flutter/feature/main/session_picker/session_picker.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key, required this.id, required this.role});

  final String id;
  final RoleDto role;

  @override
  State<StatefulWidget> createState() {
    return _EventScreenState();
  }
}

class _EventScreenState extends State<EventScreen>
    with MessageMixin, NavigationMixin, PickerMixin {
  late final EventScreenViewModel _viewModel;

  bool isLoading = false;
  bool isDeleting = false;

  RoleDto? userRole() => _viewModel.state.participants.isEmpty
      ? null
      : _viewModel.state.participants
          .firstWhere((element) => element.isSameAsUser())
          .role;

  bool canDelete() => userRole()?.canDeleteEvent ?? false;

  bool canTakeAttendance() => userRole()?.canTakeAttendance ?? false;

  bool canInviteMembers() => userRole()?.canInviteMembers ?? false;

  bool canViewParticipants() => userRole()?.canViewParticipants ?? false;

  bool canChangeRole() => userRole()?.canChangeRole ?? false;

  bool canRemoveMembers() => userRole()?.canRemoveMembers ?? false;

  @override
  void initState() {
    super.initState();
    _viewModel = EventScreenViewModel(
      getIt<EventApiService>(),
      getIt<Downloader>(),
      getIt<CSVParser>(),
    );
    _viewModel.refresh(widget.id).then(
      (value) => {},
      onError: (error) {
        String message = 'Something went wrong';
        if (error is DioException) {
          message = error.message ?? message;
        }

        snackbar(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventScreenViewModel>.value(
      value: _viewModel,
      child: Stack(
        children: [
          Scaffold(
            body: Center(
              child: SizedBox(
                width: kIsWeb ? 600 : null,
                child: Padding(
                  padding: kIsWeb
                      ? const EdgeInsets.symmetric(vertical: 32)
                      : EdgeInsets.zero,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: kIsWeb ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ] : null,
                    ),
                    child: // Your content goes here
                        ClipRRect(
                      borderRadius: kIsWeb ? BorderRadius.circular(8) : BorderRadius.zero,
                      child: Scaffold(
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
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 0, 16, 40),
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
                                              _viewModel.state.event
                                                      ?.nearestSession.id ??
                                                  "",
                                            ),
                                          if (canInviteMembers())
                                            pendingMembersSection(
                                              context,
                                              model.state.pendingMembers.isEmpty
                                                  ? []
                                                  : model.state.pendingMembers
                                                      .first.members,
                                              model.state.pendingMembers.isEmpty
                                                  ? ""
                                                  : model.state.pendingMembers
                                                      .first.id,
                                            ),
                                          membersList(
                                              context,
                                              model.state.participantsByRole ??
                                                  {})
                                        ],
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
            pushSheet(ChangeNotifierProvider<EventScreenViewModel>.value(
              value: _viewModel,
              child: const InviteMembersScreen(),
            ));
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
        Expanded(
          child: Consumer<EventScreenViewModel>(
            builder: (context, model, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.state.event?.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  Text(
                    model.state.event?.description ?? '',
                    // 'Event By Baroody Camps',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ],
              );
            },
          ),
        )
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
                ChangeNotifierProvider<EventScreenViewModel>.value(
                  value: _viewModel,
                  child: Consumer<EventScreenViewModel>(
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
                    },
                  ),
                ),
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
        onPressed: () => pushSheet(
          ChangeNotifierProvider<EventScreenViewModel>.value(
            value: _viewModel,
            child: const AttendanceScreen(),
          ),
        ),
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
      List<ParticipantDto> participantsList = canViewParticipants()
          ? participants
          : participants
              .where((participant) => participant.role == RoleDto.owner)
              .toList();
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionHeader(label, context),
          Column(
            children: List.generate(
              participantsList.length,
              (index) {
                ParticipantDto participant = participantsList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ParticipantRow(
                    avatarUrl: participant.avatarUrl,
                    name: "${participant.firstName} ${participant.lastName}",
                    onClick: () => {_onMemberClick(context, participant)},
                  ),
                );
              },
            ),
          )
        ],
      );
    }
  }

  Widget pendingMembersSection(BuildContext context,
      List<PendingMemberDto> participants, String requestId) {
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
                        requestId,
                      );
                    },
                    onDecline: () {
                      _onUpdatePendingMember(
                        false,
                        participant.role,
                        participant.adultUserId,
                        participant.memberId,
                        requestId,
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

  void removeMemberConfirmationDialog(String id) {
    dialog(
      const Text("Remove Member"),
      const Text(
          "They will be permanently removed from the current and all future sessions"),
      [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => {Navigator.pop(context)},
          child: const Text("Cancel"),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => {Navigator.pop(context), _onDeleteUser(id)},
          child: const Text("Remove"),
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

  void _onMemberClick(BuildContext context, ParticipantDto participant) {
    pushSmallSheet(
      ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: Container(
            height:
                (!participant.isSameAsUser() && userRole() == RoleDto.owner ||
                        userRole() == RoleDto.admin)
                    ? 350
                    : 200,
            padding: const EdgeInsets.only(top: 6),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              children: [
                // Header with done button
                const SheetHeader(
                  title: SizedBox(),
                ),
                // Date picker
                _memberOptionsBuilder(context, participant),

                const SizedBox(
                  height: 16,
                )
              ],
            ),
          )),
    );
  }

  Widget _memberOptionsBuilder(
    BuildContext context,
    ParticipantDto participant,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.grey[200],
                child: ClipOval(
                  child: SizedBox.fromSize(
                    child: CachedNetworkImage(
                      imageUrl: participant.avatarUrl ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Icon(
                        CupertinoIcons.person,
                        size: 32,
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        CupertinoIcons.person,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${participant.firstName} ${participant.lastName}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  Text(
                    participant.role.name.capitalize(),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          if (!participant.isSameAsUser() && userRole() == RoleDto.owner ||
              userRole() == RoleDto.admin)
            SizedBox(
              width: kIsWeb ? 350 : 600,
              child: OutlinedButton(
                onPressed: () {
                  rolePicker(
                    context,
                    participant.role,
                    (role) {
                      _onChangeUserRole(participant.memberId, role);
                    },
                  );
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        32.0), // specify the corner radius
                  ),
                  side:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Change role",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const Icon(CupertinoIcons.chevron_right)
                  ],
                ),
              ),
            ),
          const SizedBox(height: 8),
          if (!participant.isSameAsUser() && userRole() == RoleDto.owner ||
              userRole() == RoleDto.admin)
            SizedBox(
              width: kIsWeb ? 350 : 600,
              child: OutlinedButton(
                onPressed: () {
                  removeMemberConfirmationDialog(participant.memberId);
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        32.0), // specify the corner radius
                  ),
                  side: BorderSide(color: Theme.of(context).colorScheme.error),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Remove member",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                    Icon(
                      CupertinoIcons.trash,
                      color: Theme.of(context).colorScheme.error,
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
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
        .whenComplete(() {
      setState(() {
        isDeleting = false;
      });
    }).then(
      (value) => {},
      onError: (error) => {
        snackbar((error as DioException).message ?? "Something went wrong"),
      },
    );
  }

  void _onChangeUserRole(String memberId, RoleDto newRole) async {
    pop();
    setState(() {
      isDeleting = true;
    });
    _viewModel.changeMemberRole(memberId, newRole).whenComplete(() {
      setState(() {
        isDeleting = false;
      });
    }).then(
      (value) => {},
      onError: (error) => {
        snackbar((error as DioException).message ?? "Something went wrong"),
      },
    );
  }

  void _onDeleteUser(String memberId) async {
    if (_viewModel.state.selectedSession!.endDateTime
        .isBefore(DateTime.now())) {
      snackbar("You cannot delete a user from previous sessions.");
      return;
    }
    pop();
    setState(() {
      isDeleting = true;
    });
    _viewModel.deleteMember(memberId).whenComplete(() {
      setState(() {
        isDeleting = false;
      });
    }).then(
      (value) => {},
      onError: (error) => {
        snackbar((error as DioException).message ?? "Something went wrong"),
      },
    );
  }
}
