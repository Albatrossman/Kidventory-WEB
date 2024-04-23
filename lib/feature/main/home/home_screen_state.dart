import 'package:kidventory_flutter/core/data/model/session_dto.dart';

class HomeScreenState {
  final bool loading;
  final List<SessionDto> upcomingSessions;
  final String? message;

  HomeScreenState({
    this.loading = false,
    List<SessionDto>? upcomingSessions,
    this.message,
  }) : upcomingSessions = upcomingSessions ?? [];

  HomeScreenState copy({
    bool? loading,
    List<SessionDto>? upcomingSessions,
    String? message,
  }) {
    return HomeScreenState(
      loading: loading ?? this.loading,
      upcomingSessions: upcomingSessions ?? this.upcomingSessions,
      message: message ?? this.message,
    );
  }
}
