import 'package:flutter/cupertino.dart';
import 'package:kidventory_flutter/core/data/model/invited_event_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager.dart';
import 'package:kidventory_flutter/feature/main/main_screen_state.dart';

class MainScreenViewModel extends ChangeNotifier {
  final EventApiService _eventApiService;
  final TokenPreferencesManager _tokenPreferences;

  MainScreenViewModel(this._eventApiService, this._tokenPreferences);

  MainScreenState _state = MainScreenState();
  MainScreenState get state => _state;

  Future<InvitedEventDto> getEventFrom(String id) async {
    _update(loading: true);
    try {
      return await _eventApiService.getEventFromReference(id);
    } catch (exception) {
      _update(message: "Invite does not exist");
      rethrow;
    } finally {
      _update(loading: false);
    }
  }

  void resetMessage() {
    if (_state.message != null) {
      _update(message: null);
    }
  }

  void _update({bool? loading, String? message}) {
    _state = _state.copy(loading: loading, message: message);
    notifyListeners();
  }
}
