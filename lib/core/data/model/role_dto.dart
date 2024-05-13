enum RoleDto {
  owner,
  teacher,
  driver,
  participant,
  admin,
  adult;

  static List<RoleDto> selectableRoles = [
    admin,
    teacher,
    driver,
    adult,
    participant,
  ];
}

extension RoleAccess on RoleDto {
  bool get canDeleteEvent {
    switch (this) {
      case RoleDto.owner:
        return true;
      case RoleDto.teacher:
        return false;
      case RoleDto.driver:
        return false;
      case RoleDto.participant:
        return false;
      case RoleDto.admin:
        return false;
      case RoleDto.adult:
        return false;
    }
  }

  bool get canTakeAttendance {
    switch (this) {
      case RoleDto.owner:
        return true;
      case RoleDto.teacher:
        return true;
      case RoleDto.driver:
        return false;
      case RoleDto.participant:
        return false;
      case RoleDto.admin:
        return true;
      case RoleDto.adult:
        return false;
    }
  }

  bool get canInviteMembers {
    switch (this) {
      case RoleDto.owner:
        return true;
      case RoleDto.teacher:
        return false;
      case RoleDto.driver:
        return false;
      case RoleDto.participant:
        return false;
      case RoleDto.admin:
        return true;
      case RoleDto.adult:
        return false;
    }
  }

  bool get canViewParticipants {
    switch (this) {
      case RoleDto.owner:
        return true;
      case RoleDto.teacher:
        return true;
      case RoleDto.driver:
        return true;
      case RoleDto.participant:
        return false;
      case RoleDto.admin:
        return true;
      case RoleDto.adult:
        return false;
    }
  }

  bool get canChangeRole {
    switch (this) {
      case RoleDto.owner:
        return true;
      case RoleDto.teacher:
        return false;
      case RoleDto.driver:
        return false;
      case RoleDto.participant:
        return false;
      case RoleDto.admin:
        return true;
      case RoleDto.adult:
        return false;
    }
  }

  bool get canRemoveMembers {
    switch (this) {
      case RoleDto.owner:
        return true;
      case RoleDto.teacher:
        return false;
      case RoleDto.driver:
        return false;
      case RoleDto.participant:
        return false;
      case RoleDto.admin:
        return true;
      case RoleDto.adult:
        return false;
    }
  }
}
