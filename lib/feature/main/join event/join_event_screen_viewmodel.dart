import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/core/data/model/event_dto.dart';
import 'package:kidventory_flutter/core/data/model/profile_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/feature/main/join%20event/join_event_screen_state.dart';

class JoinEventScreenViewModel extends ChangeNotifier {
  final UserApiService _userApiService;

  JoinEventScreenViewModel(this._userApiService) {
    getProfile();
  }

  JoinEventScreenState _state = JoinEventScreenState();
  JoinEventScreenState get state => _state;

  void getProfile() async {
    _update(loading: true);
    try {
      ProfileDto profile = await _userApiService.getProfile("me");
      _update(profile: profile, loading: false);
    } catch (e) {
      _update(loading: false);
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