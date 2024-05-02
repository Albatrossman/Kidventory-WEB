import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/core/data/model/profile_dto.dart';
import 'package:kidventory_flutter/core/data/model/session_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/feature/main/home/home_screen_state.dart';
import 'package:kidventory_flutter/main.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final UserApiService _userApiService;

  HomeScreenViewModel(this._userApiService) {
    updateContent();
  }

  HomeScreenState _state = HomeScreenState();
  HomeScreenState get state => _state;

  void updateContent() {

      getUpcomingSessions();
      getProfile();
  }

  void getUpcomingSessions() async {
    _update(loading: true);
    try {
      List<SessionDto> sessions =
          await _userApiService.getUpcomingSessions(DateTime.now(), 3);
      _update(upcomingSessions: sessions, loading: false);
    } catch (e) {
      _update(loading: false);
    }
  }

  void getProfile() async {
    _update(loading: true);
    try {
      ProfileDto profile = await _userApiService.getProfile("me");
      globalUserProfile = profile;
      _update(profile: profile, loading: false);
    } catch (e) {
      _update(loading: false);
    }
  }

  void _update({
    bool? loading,
    List<SessionDto>? upcomingSessions,
    ProfileDto? profile,
    String? message,
  }) {
    _state = _state.copy(
      loading: loading,
      upcomingSessions: upcomingSessions,
      profile: profile,
      message: message,
    );

    notifyListeners();
  }
}
