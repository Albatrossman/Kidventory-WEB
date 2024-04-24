import 'package:kidventory_flutter/core/data/model/event_dto.dart';

class ProfileScreenState {
  final bool loading;
  final List<EventDto> events;
  final String? message;

  ProfileScreenState({
    this.loading = false,
    List<EventDto>? events,
    this.message,
  }) : events = events ?? [];

  ProfileScreenState copy({
    bool? loading,
    List<EventDto>? events,
    String? message,
  }) {
    return ProfileScreenState(
      loading: loading ?? this.loading,
      events: events ?? this.events,
      message: message ?? this.message,
    );
  }
}
