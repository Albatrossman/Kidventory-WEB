import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kidventory_flutter/core/data/model/update_invite_link_dto.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/component/csv_card.dart';
import 'package:kidventory_flutter/core/ui/component/sheet_header.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/picker_mixin.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen_viewmodel.dart';
import 'package:kidventory_flutter/feature/main/roster/roster_screen.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class InviteMembersScreen extends StatefulWidget {
  const InviteMembersScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _InviteMembersScreenState();
  }
}

class _InviteMembersScreenState extends State<InviteMembersScreen>
    with MessageMixin, NavigationMixin, PickerMixin {
  late final EventScreenViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<EventScreenViewModel>(context, listen: false);
    _isPrivate = _viewModel.state.event?.inviteLink?.isPrivate ?? true;
    _expirationDate = _viewModel.state.event?.inviteLink?.expirationDate ??
        DateTime.now().add(const Duration(days: 1));
    _canExpire = _viewModel.state.event?.inviteLink?.expirationDate != null;
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.removeAllCSV();
  }

  final MaterialStateProperty<Icon?> _thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  late final String _inviteLink =
      "http://kid.softballforce.com/invite?id=${_viewModel.state.event?.inviteLink?.referenceId ?? ""}";
  bool _isPrivate = false;
  bool _canExpire = false;
  DateTime _expirationDate = DateTime.now().add(const Duration(days: 1));
  bool _updating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SheetHeader(
        title: const Text("Add members"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => {_updateSettings()},
          child: _updating
              ? const CupertinoActivityIndicator(
                  animating: true,
                )
              : const Text("Confirm"),
        ),
      ),
      body: Center(
        heightFactor: kIsWeb ? null : 1.3,
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: kIsWeb ? 420 : null,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: inviteLinkSection(context),
                        ),
                        const SizedBox(height: 32),
                        uploadCSVButton(context),
                        const SizedBox(height: 16),
                        _csvMemberListBuilder(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inviteLinkSection(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Invite Link',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.centerLeft,
              child: SelectionArea(child: Text(_inviteLink)),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SizedBox(
                    height: kIsWeb ? 40 : 32,
                    child: FilledButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Theme.of(context)
                                  .colorScheme
                                  .primaryContainer)),
                      child: Text(
                        "Copy",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                      ),
                      onPressed: () => {
                        Clipboard.setData(
                          ClipboardData(text: _inviteLink),
                        )
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: kIsWeb ? 40 : 32,
                    child: FilledButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Theme.of(context)
                                  .colorScheme
                                  .primaryContainer)),
                      child: Text(
                        "Share",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                      ),
                      onPressed: () => {
                        Share.share(
                            "You are invited to join ${_viewModel.state.event?.name ?? ""}!\n\n$_inviteLink${_canExpire ? "\n\n This link expires on ${_expirationDate.formatDate()}" : ""}")
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            inviteLinkOptions(context),
          ],
        ));
  }

  Widget inviteLinkOptions(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          expirationDateField(context),
          const Divider(),
          isPrivateModeToggle(context),
        ],
      ),
    );
  }

  Widget expirationDateField(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Expires",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const Spacer(),
            Switch(
              thumbIcon: _thumbIcon,
              value: _canExpire,
              onChanged: (bool value) {
                setState(() {
                  _canExpire = value;
                });
              },
            ),
            // Text("Never"),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: _canExpire
              ? Column(
                  children: [
                    const SizedBox(height: 8.0),
                    SizedBox(
                      height: 40,
                      width: 500,
                      child: OutlinedButton(
                        onPressed: _showDatePicker,
                        child: Text(
                          _expirationDate.formatDate(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                )
              : const SizedBox(width: double.infinity, height: 0),
        ),
      ],
    );
  }

  Widget isPrivateModeToggle(BuildContext context) {
    return Row(
      children: [
        Text(
          "Private",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const Spacer(),
        Switch(
          thumbIcon: _thumbIcon,
          value: _isPrivate,
          onChanged: (bool value) {
            setState(() {
              _isPrivate = value;
            });
          },
        ),
      ],
    );
  }

  Widget uploadCSVButton(BuildContext context) {
    return SizedBox(
      width: 800,
      height: 40,
      child: Consumer<EventScreenViewModel>(
        builder: (_, model, __) {
          return OutlinedButton(
            onPressed: () async {
              File? file = await csvPicker();

              if (file != null) {
                _viewModel.importCSV(file);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Upload CSV",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(width: 8),
                const Icon(CupertinoIcons.add_circled),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _csvMemberListBuilder(BuildContext context) {
    return Consumer<EventScreenViewModel>(
      builder: (_, model, __) {
        return Column(
          children: List.generate(
            _viewModel.state.filesAndParticipants.length,
            (index) {
              File file =
                  _viewModel.state.filesAndParticipants.keys.elementAt(index);
              return Column(
                children: [
                  CSVCard(
                    file: file,
                    members: _viewModel.state.filesAndParticipants[file]!,
                    onClick: () => pushSheet(RosterScreen(
                        members: _viewModel.state.filesAndParticipants[file] ??
                            List.empty())),
                    onRemoveClick: () => _viewModel.removeCSV(file),
                  ),
                  const SizedBox(height: 8.0),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _showDatePicker() {
    datePicker(
      context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateTime: _expirationDate,
      onSelectedDate: (date) => {
        setState(() {
          _expirationDate = date;
        })
      },
    );
  }

  void _updateSettings() async {
    setState(() {
      _updating = true;
    });
    String eventId = _viewModel.state.event?.id ?? "";
    if (_viewModel.state.filesAndParticipants.isNotEmpty) {
      await _viewModel.addMembers(eventId);
    }
    await _viewModel
        .updateInviteLink(
            eventId,
            UpdateInviteLinkDto(
                isActive:
                    _expirationDate.isBefore(DateTime.now()) ? false : true,
                isPrivate: _isPrivate,
                expirationDate: _canExpire ? _expirationDate : null))
        .whenComplete(() {
      setState(() {
        _updating = false;
        _viewModel.refresh(eventId);
      });
    }).then(
      (value) => pop(),
      onError: (error) => {
        snackbar((error as DioException).message ?? "Something went wrong"),
      },
    );
  }
}
