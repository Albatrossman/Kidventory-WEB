import 'package:kidventory_flutter/core/data/model/event_dto.dart';

class EventsScreenState {
  final bool loading;
  final List<EventDto> events;
  final String? message;

  EventsScreenState({
    this.loading = false,
    List<EventDto>? events,
    this.message,
  }) : events = events ?? [];

  EventsScreenState copy({
    bool? loading,
    List<EventDto>? events,
    String? message,
  }) {
    return EventsScreenState(
      loading: loading ?? this.loading,
      events: events ?? this.events,
      message: message ?? this.message,
    );
  }
}
