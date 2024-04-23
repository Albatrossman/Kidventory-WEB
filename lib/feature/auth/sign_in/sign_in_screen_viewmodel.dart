import 'package:flutter/cupertino.dart';
import 'package:kidventory_flutter/core/data/mapper/token_mapper.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager.dart';
import 'package:kidventory_flutter/feature/auth/sign_in/sign_in_screen_state.dart';

class SignInScreenViewModel extends ChangeNotifier {
  final AuthApiService _authApiService;
  final TokenPreferencesManager _tokenPreferences;

  SignInScreenViewModel(this._authApiService, this._tokenPreferences);

  SignInScreenState _state = SignInScreenState();
  SignInScreenState get state => _state;

  Future<void> signIn(String email, String password) async {
    _update(loading: true);
    try {
      final tokenDto = await _authApiService.signIn(email, password);
      _tokenPreferences.saveToken(tokenDto.toDomain());
      _update(message: tokenDto.accessToken);
    } catch (exception) {
      _update(message: "Incorrect email or password.");
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
