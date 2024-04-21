import 'package:kidventory_flutter/core/domain/model/attendance.dart';
import 'package:kidventory_flutter/core/domain/model/gender.dart';
import 'package:kidventory_flutter/core/domain/model/role.dart';

class Participant {
  final String id;
  final String? sessionId;
  final String? avatarUrl;
  final String firstname;
  final String lastname;
  final String? email;
  final List<String>? phones;
  final int? age;
  final Gender? gender;
  final String? parent;
  final String? guardian;
  final String? address;
  final Role role;
  final Attendance? attendance;

  Participant({
    required this.id,
    this.sessionId,
    this.avatarUrl,
    required this.firstname,
    required this.lastname,
    this.email,
    this.phones,
    this.age,
    this.gender,
    this.parent,
    this.guardian,
    this.address,
    required this.role,
    this.attendance,
  });
}
