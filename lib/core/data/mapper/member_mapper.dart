import 'package:kidventory_flutter/core/data/mapper/gender_mapper.dart';
import 'package:kidventory_flutter/core/data/mapper/role_mapper.dart';
import 'package:kidventory_flutter/core/data/model/member_dto.dart';
import 'package:kidventory_flutter/core/domain/model/member.dart';
import 'package:kidventory_flutter/core/domain/util/int_ext.dart';

extension DomainExtension on Member {
  MemberDto toData() {
    return MemberDto(
      firstName: firstName,
      lastName: lastName,
      email: email,
      birthday: age.birthday,
      gender: gender?.toData(),
      address: address,
      role: role?.toData(),
      primaryGuardian: primaryGuardian,
      phone: phone,
    );
  }
}