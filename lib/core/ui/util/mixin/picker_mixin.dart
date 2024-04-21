import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

mixin PickerMixin<T extends StatefulWidget> on State<T> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  void datePicker(
    BuildContext context, {
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    if (kIsWeb) {
      showDatePicker(
        context: context,
        firstDate: firstDate ?? DateTime(1900),
        lastDate: lastDate ?? DateTime(2100),
      );
    } else {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: 250,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedDate,
                  minimumDate: firstDate ?? DateTime(1900),
                  maximumDate: lastDate ?? DateTime(2100),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      selectedDate = newDate;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void timePicker(
    BuildContext context, {
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    if (kIsWeb) {
      showDatePicker(
        context: context,
        firstDate: firstDate ?? DateTime(1900),
        lastDate: lastDate ?? DateTime(2100),
      );
    } else {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Wrap(
          children: [
            Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      ),
                      onDateTimeChanged: (DateTime newTime) {
                        setState(() {
                          selectedTime = TimeOfDay.fromDateTime(newTime);
                        });
                      },
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
