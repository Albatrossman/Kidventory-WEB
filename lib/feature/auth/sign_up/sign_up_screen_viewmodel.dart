import 'package:flutter/cupertino.dart';
import 'package:kidventory_flutter/core/data/model/sign_up_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:kidventory_flutter/feature/auth/sign_up/sign_up_screen_state.dart';

class SignUpScreenViewModel extends ChangeNotifier {
  final AuthApiService _authApiService;

  SignUpScreenViewModel(this._authApiService);

  SignUpScreenState _state = SignUpScreenState();
  SignUpScreenState get state => _state;

  Future<void> signUp(
    String email,
    String firstname,
    String lastname,
    String password,
  ) async {
    _update(loading: true);
    try {
      final tokenDto = await _authApiService.signUp(
        SignUpDto(
          email: email,
          password: password,
          firstname: firstname,
          lastname: lastname,
          timezone: "UTC",
        ),
      );

      if (tokenDto.statusCode == 200) {
        _update(message: tokenDto.accessToken);
      } else {
        _update(message: "Incorrect email or password.");
      }
    } catch (exception) {
      _update(message: "Incorrect email or password.");
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
