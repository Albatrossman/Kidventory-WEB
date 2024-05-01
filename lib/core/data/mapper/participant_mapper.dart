import 'package:kidventory_flutter/core/data/mapper/attendance_mapper.dart';
import 'package:kidventory_flutter/core/data/mapper/role_mapper.dart';
import 'package:kidventory_flutter/core/data/model/participant_dto.dart';
import 'package:kidventory_flutter/core/domain/model/participant.dart';

extension DataExtension on ParticipantDto {
  Participant toDomain() {
    return Participant(
      id: memberId,
      avatarUrl: avatarUrl,
      firstname: firstName,
      lastname: lastName,
      role: role.toDomain(),
      attendance: attendance.toDomain(),
      phones: [],
      parent: null,
      email: null,
      age: null,
      gender: null,
      guardian: null,
      address: null,
    );
  }
}

extension DomainExtension on Participant {
  ParticipantDto toData() {
    return ParticipantDto(
      memberId: id,
      avatarUrl: avatarUrl,
      firstName: firstname,
      lastName: lastname,
      attendance: attendance.toData(),
      role: role.toData(),
    );
  }
}