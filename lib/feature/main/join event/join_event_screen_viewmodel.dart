import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/core/data/model/join_from_invite_dto.dart';
import 'package:kidventory_flutter/core/data/model/profile_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/event_api_service.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/feature/main/join%20event/join_event_screen_state.dart';

class JoinEventScreenViewModel extends ChangeNotifier {
  final UserApiService _userApiService;
  final EventApiService _eventApiService;

  JoinEventScreenViewModel(this._userApiService, this._eventApiService) {
    getProfile();
  }

  JoinEventScreenState _state = JoinEventScreenState();
  JoinEventScreenState get state => _state;

  Future<void> joinPrivateEvent(String id, JoinFromInvitetDto request) async {
    _update(loading: true);
    try {
      await _eventApiService.joinPrivateEvent(id, request);
    } catch (e) {
      _update(loading: false);
      rethrow;
    }
  }

  Future<void> joinPublicEvent(String id, JoinFromInvitetDto request) async {
    _update(loading: true);
    try {
      await _eventApiService.joinPublicEvent(id, request);
    } catch (e) {
      _update(loading: false);
      rethrow;
    }
  }

  void getProfile() async {
    _update(loading: true);
    try {
      ProfileDto profile = await _userApiService.getProfile("me");
      _update(profile: profile, loading: false);
    } catch (e) {
      _update(loading: false);
      rethrow;
    }
  }

  void _update({
    bool? loading,
    ProfileDto? profile,
    String? message,
  }) {
    _state = _state.copy(
      loading: loading,
      profile: profile,
      message: message,
    );

    notifyListeners();
  }
}
