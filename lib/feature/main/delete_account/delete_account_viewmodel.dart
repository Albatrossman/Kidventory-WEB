import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/core/data/model/delete_account_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager.dart';
import 'package:kidventory_flutter/feature/main/delete_account/delete_account_state.dart';

class DeleteAccountScreenViewModel extends ChangeNotifier {
  final TokenPreferencesManager _tokenPreferencesManager;
  final AuthApiService _authApiService;

  DeleteAccountScreenViewModel(this._authApiService, this._tokenPreferencesManager);

  DeleteAccountScreenState _state = DeleteAccountScreenState();

  DeleteAccountScreenState get state => _state;

  Future signOut() async {
    _tokenPreferencesManager.clearToken();
  }

  Future<void> deleteAccount(
    String email,
    String currentPassword,
  ) async {
    _update();
    try {
      final _ = await _authApiService.deleteAccount(
        DeleteAccountDto(
          email: email,
          password: currentPassword,
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
