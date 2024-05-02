import 'package:kidventory_flutter/core/data/mapper/role_mapper.dart';
import 'package:kidventory_flutter/core/data/model/member_dto.dart';
import 'package:kidventory_flutter/core/domain/model/member.dart';

extension DomainExtension on Member {
  MemberDto toData() {
    return MemberDto(
      firstName: firstName,
      lastName: lastName,
      email: email,
      age: age,
      gender: gender,
      address: address,
      role: role.toData(),
      primaryGuardian: primaryGuardian,
      phone: phone,
    );
  }
}