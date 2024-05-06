import 'package:kidventory_flutter/core/data/model/profile_dto.dart';
import 'package:kidventory_flutter/core/data/model/session_dto.dart';

class CalendarScreenState {
  final bool loading;
  final List<SessionDto> upcomingSessions;
  final String? message;

  CalendarScreenState({
    this.loading = false,
    List<SessionDto>? upcomingSessions,
    ProfileDto? profile,
    this.message,
  })  : upcomingSessions = upcomingSessions ?? [];

  CalendarScreenState copy({
    bool? loading,
    List<SessionDto>? upcomingSessions,
    String? message,
  }) {
    return CalendarScreenState(
      loading: loading ?? this.loading,
      upcomingSessions: upcomingSessions ?? this.upcomingSessions,
      message: message ?? this.message,
    );
  }
}
