import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:kidventory_flutter/core/data/service/csv/csv_parser.dart';
import 'package:kidventory_flutter/core/domain/model/member.dart';
import 'package:kidventory_flutter/core/domain/model/role.dart';

class ParticipantCSVParser implements CSVParser<List<Member>> {
  @override
  List<Member> parse(String content) {
    List<Member> participants = [];
    DateTime now = DateTime.now();
    var lines = const LineSplitter().convert(content);
    int lineNumber = 0;

    for (var line in lines) {
      lineNumber++;
      if (lineNumber == 1 || line.trim().isEmpty) continue;

      var values = line.split(',');
      if (values.length < 10) {
        print('Skipping line $lineNumber due to insufficient columns: $line');
        continue;
      }

      try {
        DateTime dob = _parseDate(values[2].trim());
        int age = now.year - dob.year;
        if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
          age--;
        }

        participants.add(Member(
          firstName: values[0].trim(),
          lastName: values[1].trim(),
          email: values[6].trim(),
          age: age,
          gender: values[3].trim(),
          address: values[9].trim(),
          role: Role.participant,
          primaryGuardian: "${values[4].trim()} ${values[5].trim()}",
          phone: [values[7].trim(), values[8].trim()].where((phone) => phone.isNotEmpty).toList(),
        ));
      } catch (e) {
        print('Error parsing line $lineNumber: $e');
        throw Exception('Error parsing line $lineNumber: $e');
      }
    }

    return participants;
  }

  DateTime _parseDate(String date) {
    List<String> formats = ['yyyy-MM-dd', 'yyyy/MM/dd'];
    for (var format in formats) {
      try {
        return DateFormat(format).parseStrict(date);
      } catch (e) {
        // Continue trying other formats
      }
    }
    throw FormatException('No valid date format found for $date');
  }
}
