import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/model/role_dto.dart';
import 'package:kidventory_flutter/core/domain/util/datetime_ext.dart';
import 'package:kidventory_flutter/core/ui/component/multi_select_card.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

mixin PickerMixin<T extends StatefulWidget> on State<T> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  late DateTime _unSavedSelectedDate;
  late TimeOfDay _unSavedSelectedTime;

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
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: Container(
              height: 300,
              padding: const EdgeInsets.only(top: 6),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: Column(
                children: [
                  // Header with done button
                  _buildHeader(context, null,
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
            ),
          );
        },
      );
    }
  }

  RoleDto? selectedRole = null;

  void rolePicker(
    BuildContext context,
    RoleDto initialSelectedRole,
    final void Function(RoleDto) onSelectedRole,
  ) async {
    selectedRole = initialSelectedRole;

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 6),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              children: [
                // Header with done button
                _buildHeader(context, "Select Role", onDone: null),
                // Date picker
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: RoleDto.values.length,
                    itemBuilder: (BuildContext context, int index) {
                      RoleDto role = RoleDto.values[index];
                      bool isSelected = selectedRole == role;
                      return MultiSelectCard(
                        name: role.toString().split('.').last,
                        isSelected: isSelected,
                        onClick: () {
                          onSelectedRole(selectedRole!);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, String? title,
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
          SizedBox(
            width: 90,
            child: CupertinoButton(
              // padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          if (title != null)
            DefaultTextStyle(
              style:
                  Theme.of(context).textTheme.titleSmall ?? const TextStyle(),
              child: Text(title),
            ),
          if (onDone != null)
            SizedBox(
              width: 90,
              child: CupertinoButton(
                child: const Text('Done'),
                onPressed: () {
                  onDone(); // Call the callback
                  Navigator.pop(context);
                },
              ),
            )
          else
            const SizedBox(width: 90)
        ],
      ),
    );
  }

  void timePicker(
    BuildContext context, {
    required void Function(TimeOfDay) onSelectedTime,
    String title = "Pick a time",
    TimeOfDay? initialTime,
    TimeOfDay? minimumTime,
    TimeOfDay? maximumTime,
  }) {
    initialTime ??= TimeOfDay.now();
    minimumTime ??= TimeOfDay.now();
    maximumTime ??= const TimeOfDay(hour: 24, minute: 60);
    _unSavedSelectedTime = initialTime;

    if (kIsWeb) {
      showTimePicker(
        context: context,
        initialTime: initialTime,
      );
    } else {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: Container(
              height: 300,
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                children: [
                  _buildHeader(
                    context,
                    title,
                    onDone: () {
                      onSelectedTime(_unSavedSelectedTime);
                    },
                  ),
                  // SheetHeader(title: title),
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (DateTime newTime) {
                        _unSavedSelectedTime = TimeOfDay.fromDateTime(newTime);
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
          );
        },
      );
    }
  }

  Future<File?> csvPicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['csv'], withData: true);

      if (result != null) {
        PlatformFile platformFile = result.files.first;

        if (platformFile.path != null) {
          File file = File(platformFile.path!);
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
