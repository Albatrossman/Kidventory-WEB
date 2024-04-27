import 'package:kidventory_flutter/core/data/model/profile_dto.dart';

class ProfileScreenState {
  final bool loading;
  late ProfileDto? profile;
  final String? message;

  ProfileScreenState({
    this.loading = false,
    ProfileDto? profile,
    this.message,
  }) : profile = profile ?? ProfileDto(id: "", avatarUrl: "", email: "", password: "", firstName: "", lastName: "", timeZone: "UTC", phone: [], children: []);

  ProfileScreenState copy({
    bool? loading,
    ProfileDto? profile,
    String? message,
  }) {
    return ProfileScreenState(
      loading: loading ?? this.loading,
      profile: profile ?? this.profile,
      message: message ?? this.message,
    );
  }
}
