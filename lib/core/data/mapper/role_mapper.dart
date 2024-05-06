import 'package:kidventory_flutter/core/data/model/role_dto.dart';
import 'package:kidventory_flutter/core/domain/model/role.dart';

extension DataExtension on RoleDto {
  Role toDomain() {
    switch (this) {
      case RoleDto.owner:
        return Role.owner;
      case RoleDto.teacher:
        return Role.teacher;
      case RoleDto.participant:
        return Role.participant;
      default:
        throw Role.participant;
    }
  }
}

extension DomainExtension on Role {
  RoleDto toData() {
    switch (this) {
      case Role.owner:
        return RoleDto.owner;
      case Role.teacher:
        return RoleDto.teacher;
      case Role.participant:
        return RoleDto.participant;
      default:
        throw Role.participant;
    }
  }
}