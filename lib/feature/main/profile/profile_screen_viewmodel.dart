import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kidventory_flutter/core/data/model/profile_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager.dart';
import 'package:kidventory_flutter/feature/main/profile/profile_screen_state.dart';

class ProfileScreenViewModel extends ChangeNotifier {
  final UserApiService _userApiService;
  final TokenPreferencesManager _tokenPreferencesManager;

  ProfileScreenViewModel(this._userApiService, this._tokenPreferencesManager) {
    getProfile();
  }

  ProfileScreenState _state = ProfileScreenState();
  ProfileScreenState get state => _state;

  Future signOut() async {
    _tokenPreferencesManager.clearToken();
  }

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