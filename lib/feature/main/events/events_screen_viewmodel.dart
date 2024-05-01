import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/event_list_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/feature/main/events/events_screen_state.dart';

class EventsScreenViewModel extends ChangeNotifier {
  final UserApiService _userApiService;

  EventsScreenViewModel(this._userApiService) {
    getEvents();
  }

  EventsScreenState _state = EventsScreenState();
  EventsScreenState get state => _state;

  void getEvents() async {
    _update(loading: true);
    try {
      EventListDto events = await _userApiService.getEvents(100, 0);
      _update(events: events.items, loading: false);
    } catch (e) {
      _update(loading: false);
    }
  }

  void _update({
    bool? loading,
    List<EventDto>? events,
    String? message,
  }) {
    _state = _state.copy(
      loading: loading,
      events: events,
      message: message,
    );

    notifyListeners();
  }
}