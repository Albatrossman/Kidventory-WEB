import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/domain/model/attendance.dart';
import 'package:kidventory_flutter/core/ui/component/attendance_row.dart';
import 'package:kidventory_flutter/core/ui/component/sheet_header.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/message_mixin.dart';
import 'package:kidventory_flutter/core/ui/util/mixin/navigation_mixin.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AttendanceScreenState();
  }
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with MessageMixin, NavigationMixin {
  Attendance _attendance = Attendance.unspecified;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SheetHeader(
        title: Expanded(
          child: Text("Attendance"),
        ),
        trailing: Text("Confirm"),
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
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.outline),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sunday, April 21, 2024',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer),
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
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8.0)),
                child: Container(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceVariant
                      .withAlpha(48),
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
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .outlineVariant),
                          ),
                          const Expanded(child: SizedBox()),
                          CupertinoButton(
                            onPressed: () {},
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Late',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outlineVariant),
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () {},
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'Absent',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outlineVariant),
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () {},
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                              'Present',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outlineVariant),
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
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(8.0)),
                  child: Container(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceVariant
                        .withAlpha(48),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: _participantsList(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _participantsList(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Column(
          children: [
            AttendanceRow(
              name: 'Participant $index',
              attendance: _attendance,
              onAttendanceChanged: (Attendance newAttendance) {
                setState(() {
                  _attendance = newAttendance;
                });
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
