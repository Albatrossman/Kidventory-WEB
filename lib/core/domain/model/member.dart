import 'package:kidventory_flutter/core/domain/model/role.dart';

class Member {
  String firstName;
  String lastName;
  String email;
  int age;
  String gender;
  String address;
  Role role;
  String? primaryGuardian;
  List<String> phone;

  Member({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
    required this.gender,
    required this.address,
    required this.role,
    required this.primaryGuardian,
    required this.phone,
  });
}
