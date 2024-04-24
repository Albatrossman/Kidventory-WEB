import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/feature/main/profile/profile_screen_state.dart';

class ProfileScreenViewModel extends ChangeNotifier {
  final UserApiService _userApiService;

  ProfileScreenViewModel(this._userApiService) {
    getEvents();
  }

  ProfileScreenState _state = ProfileScreenState();
  ProfileScreenState get state => _state;

  void getEvents() async {
    _update(loading: true);
    try {
      List<EventDto> events = await _userApiService.getEvents(100, 0);
      _update(events: events, loading: false);
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