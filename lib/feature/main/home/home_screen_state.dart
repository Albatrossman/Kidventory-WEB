import 'package:kidventory_flutter/core/data/model/profile_dto.dart';
import 'package:kidventory_flutter/core/data/model/session_dto.dart';

class HomeScreenState {
  final bool loading;
  final List<SessionDto> upcomingSessions;
  final String? message;
  late ProfileDto? profile;

  HomeScreenState({
    this.loading = false,
    List<SessionDto>? upcomingSessions,
    ProfileDto? profile,
    this.message,
  })  : upcomingSessions = upcomingSessions ?? [],
        profile = profile ??
            ProfileDto(
              id: "",
              avatarUrl: "",
              email: "",
              password: "",
              firstName: "",
              lastName: "",
              timeZone: "UTC",
              phone: [],
              children: [],
            );

  HomeScreenState copy({
    bool? loading,
    List<SessionDto>? upcomingSessions,
    ProfileDto? profile,
    String? message,
  }) {
    return HomeScreenState(
      loading: loading ?? this.loading,
      upcomingSessions: upcomingSessions ?? this.upcomingSessions,
      profile: profile ?? this.profile,
      message: message ?? this.message,
    );
  }
}
