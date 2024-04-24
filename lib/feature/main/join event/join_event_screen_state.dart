import 'package:kidventory_flutter/core/data/model/event_dto.dart';

class JoinEventScreenState {
  final bool loading;
  final List<EventDto> events;
  final String? message;

  JoinEventScreenState({
    this.loading = false,
    List<EventDto>? events,
    this.message,
  }) : events = events ?? [];

  JoinEventScreenState copy({
    bool? loading,
    List<EventDto>? events,
    String? message,
  }) {
    return JoinEventScreenState(
      loading: loading ?? this.loading,
      events: events ?? this.events,
      message: message ?? this.message,
    );
  }
}
