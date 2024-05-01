import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/component/sheet_header.dart';

mixin PickerMixin<T extends StatefulWidget> on State<T> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  late DateTime _unSavedSelectedDate;

  void datePicker(
    BuildContext context, {
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDateTime,
    final void Function(DateTime)? onSelectedDate,
  }) {
    _unSavedSelectedDate = initialDateTime ?? DateTime.now();
    if (kIsWeb) {
      showDatePicker(
        context: context,
        firstDate: firstDate?.atStartOfDay ?? DateTime(1900),
        lastDate: lastDate ?? DateTime(2100),
        currentDate: initialDateTime,
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            padding: const EdgeInsets.only(top: 6),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              children: [
                // Header with done button
                _buildHeader(context,
                    onDone: () => {
                          if (onSelectedDate != null)
                            {onSelectedDate(_unSavedSelectedDate)}
                        }),
                // Date picker
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: initialDateTime ?? DateTime.now(),
                    minimumDate: firstDate?.atStartOfDay ?? DateTime(1900),
                    maximumDate: lastDate ?? DateTime(2100),
                    onDateTimeChanged: (DateTime date) {
                      setState(() {
                        _unSavedSelectedDate = date;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          );
        },
      );
    }
  }

  Widget _buildHeader(BuildContext context,
      {required void Function()? onDone}) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: CupertinoColors.separator.resolveFrom(context),
                  width: 0.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoButton(
            child: const Text('Done'),
            onPressed: () {
              if (onDone != null) {
                onDone(); // Call the callback
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void timePicker(
    BuildContext context, {
    required Function(TimeOfDay) onTimeChanged,
    Widget title = const Text('Pick a time'),
    TimeOfDay? initialTime,
    TimeOfDay? minimumTime,
    TimeOfDay? maximumTime,
  }) {
    initialTime ??= TimeOfDay.now();
    minimumTime ??= TimeOfDay.now();
    maximumTime ??= const TimeOfDay(hour: 23, minute: 59);

    if (kIsWeb) {
      showTimePicker(
        context: context,
        initialTime: initialTime,
      );
    } else {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Wrap(
          children: [
            Container(
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                children: [
                  SheetHeader(title: title),
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (DateTime newTime) {
                        onTimeChanged(TimeOfDay.fromDateTime(newTime));
                      },
                      initialDateTime: DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        initialTime?.hour ?? selectedDate.hour,
                        initialTime?.minute ?? selectedDate.minute,
                      ),
                      minimumDate: DateTime.now().copyWith(
                        hour: minimumTime?.hour,
                        minute: minimumTime?.minute,
                      ),
                      maximumDate: DateTime.now().copyWith(
                        hour: maximumTime?.hour,
                        minute: maximumTime?.minute,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<File?> csvPicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (result != null) {
        PlatformFile platformFile = result.files.first;

        if (platformFile.path != null) {
          File file = File(platformFile.path!);
          print('CSV file path: ${file.path}');
          return file;
        }
      } else {
        print('No file selected');
      }
    } catch (e) {
      print('Error picking file: $e');
    }

    return null;
  }
}
