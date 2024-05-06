import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/mapper/attendance_mapper.dart';
import 'package:kidventory_flutter/core/data/model/attendance_dto.dart';
import 'package:kidventory_flutter/core/data/model/participant_dto.dart';
import 'package:kidventory_flutter/core/domain/model/attendance.dart';
import 'package:kidventory_flutter/core/ui/component/attendance_row.dart';
import 'package:kidventory_flutter/core/ui/component/sheet_header.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';
import 'package:kidventory_flutter/feature/main/event/event_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AttendanceScreenState();
  }
}

class _AttendanceScreenState extends State<AttendanceScreen> with MessageMixin, NavigationMixin {
  late final EventScreenViewModel _viewModel;
  bool _updating = false;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<EventScreenViewModel>(context, listen: false);
    _viewModel.getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SheetHeader(
        title: const Expanded(
          child: Text("Attendance"),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              _updating = true;
            });
            _viewModel.updateAttendances().whenComplete(() {
              setState(() {
                _updating = false;
              });
              pop();
            });
          },
          child: _updating
              ? const CupertinoActivityIndicator(
                  animating: true,
                )
              : const Text("Confirm"),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current session:',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Theme.of(context).colorScheme.outline),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sunday, April 21, 2024',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _buildStat(
                              context,
                              CupertinoIcons.person_crop_circle,
                              '0 Members',
                            ),
                          ),
                          Expanded(
                            child: _buildStat(
                              context,
                              CupertinoIcons.person_crop_circle_badge_xmark,
                              '0 Absent',
                            ),
                          ),
                          Expanded(
                            child: _buildStat(
                              context,
                              CupertinoIcons.person_crop_circle_badge_checkmark,
                              '0 Present',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
                child: Container(
                  color: Theme.of(context).colorScheme.surfaceVariant.withAlpha(48),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const SizedBox(width: 12.0),
                          Text(
                            'Participants',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: Theme.of(context).colorScheme.outlineVariant),
                          ),
                          const Expanded(child: SizedBox()),
                          CupertinoButton(
                            onPressed: () => _viewModel.editAllAttendances(AttendanceDto.late),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Late',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Theme.of(context).colorScheme.outlineVariant),
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () => _viewModel.editAllAttendances(AttendanceDto.absent),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'Absent',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Theme.of(context).colorScheme.outlineVariant),
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () => _viewModel.editAllAttendances(AttendanceDto.present),
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                              'Present',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Theme.of(context).colorScheme.outlineVariant),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 4),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8.0)),
                  child: Container(
                    color: Theme.of(context).colorScheme.surfaceVariant.withAlpha(48),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Consumer<EventScreenViewModel>(builder: (context, model, child) {
                      return _participantsList(context, model.state.updatedAttendances);
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _participantsList(BuildContext context, List<ParticipantDto> participants) {
    return ListView.builder(
      itemCount: participants.length,
      itemBuilder: (context, index) {
        ParticipantDto participant = participants[index];
        return Column(
          children: [
            AttendanceRow(
              name: "${participant.firstName} ${participant.lastName}",
              attendance: participant.attendance.toDomain(),
              onAttendanceChanged: (Attendance newAttendance) {
                _viewModel.editAttendance(participant, newAttendance.toData());
              },
            ),
            const Divider(),
          ],
        );
      },
    );
  }

  Widget _buildStat(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ],
    );
  }
}
