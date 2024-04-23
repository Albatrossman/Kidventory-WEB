import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager.dart';

class MainViewModel with ChangeNotifier {
  final TokenPreferencesManager _tokenPreferences;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  MainViewModel(this._tokenPreferences) {
    Future.microtask(() => checkToken());
  }

  void checkToken() async {
    try {
      var token = await _tokenPreferences.getToken();
      _isAuthenticated = token != null;
    } catch (e) {
      _isAuthenticated = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}