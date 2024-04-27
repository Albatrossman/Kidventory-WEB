import 'package:flutter/cupertino.dart';
import 'package:kidventory_flutter/core/data/mapper/token_mapper.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager.dart';
import 'package:kidventory_flutter/feature/auth/forgot_password/forgot_password_screen_state.dart';

class ForgotPasswordScreenViewModel extends ChangeNotifier {
  final AuthApiService _authApiService;
  final TokenPreferencesManager _tokenPreferences;

  ForgotPasswordScreenViewModel(this._authApiService, this._tokenPreferences);

  ForgotPasswordScreenState _state = ForgotPasswordScreenState();
  ForgotPasswordScreenState get state => _state;

  Future<void> signIn(String email, String password) async {
    _update(loading: true);
    try {
      final tokenDto = await _authApiService.signIn(email, password);
      _tokenPreferences.saveToken(tokenDto.toDomain());
      _update(message: tokenDto.accessToken);
    } catch (exception) {
      _update(message: "Email does not exist");
      rethrow;
    } finally {
      _update(loading: false);
    }
  }

  Future<void> sendOTP(String email) async {
    _update(loading: true);
    try {
      final tokenDto = await _authApiService.sendOTP(email);
      
    } finally {
      _update(loading: false);
    }
  }

  Future<void> verifyOTP(String email, String code) async {
    _update(loading: true);
    try {
      final tokenDto = await _authApiService.validateOTP(email, code);
    } finally {
      _update(loading: false);
    }
  }

  Future<void> resetPassword(String email, String code, String password) async {
    _update(loading: true);
    try {
      final tokenDto =
          await _authApiService.resetPassword(email, code, password);
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
