import 'package:kidventory_flutter/core/data/model/attendance_dto.dart';
import 'package:kidventory_flutter/core/domain/model/attendance.dart';

extension DataExtension on AttendanceDto {
  Attendance toDomain() {
    switch (this) {
      case AttendanceDto.unspecified:
        return Attendance.unspecified;
      case AttendanceDto.late:
        return Attendance.late;
      case AttendanceDto.absent:
        return Attendance.absent;
      default:
        return Attendance.unspecified;
    }
  }
}

extension DomainExtension on Attendance {
  AttendanceDto toData() {
    switch (this) {
      case Attendance.unspecified:
        return AttendanceDto.unspecified;
      case Attendance.late:
        return AttendanceDto.late;
      case Attendance.absent:
        return AttendanceDto.absent;
      default:
        return AttendanceDto.unspecified;
    }
  }
}
