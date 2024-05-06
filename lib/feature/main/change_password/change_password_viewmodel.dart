import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/core/data/model/update_password_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:kidventory_flutter/feature/main/change_password/change_password_state.dart';

class ChangePasswordScreenViewModel extends ChangeNotifier {
  final AuthApiService _authApiService;

  ChangePasswordScreenViewModel(this._authApiService);

  ChangePasswordScreenState _state = ChangePasswordScreenState();

  ChangePasswordScreenState get state => _state;

  Future<void> changePassword(
    String email,
    String currentPassword,
    String newPassword,
    String confirmNewPassword,
  ) async {
    _update();
    try {
      final _ = await _authApiService.changePassword(
        UpdatePasswordDto(
          email: email,
          currentPassword: currentPassword,
          newPassword: newPassword,
          confirmNewPassword: confirmNewPassword,
        ),
      );
    } finally {
      _update();
    }
  }

  void _update() {
    _state = _state.copy();
    notifyListeners();
  }
}
