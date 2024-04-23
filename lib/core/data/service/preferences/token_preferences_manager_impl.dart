import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kidventory_flutter/core/data/service/preferences/token_preferences_manager.dart';
import 'package:kidventory_flutter/core/domain/model/token.dart';

class TokenPreferencesManagerImpl extends TokenPreferencesManager {

  final FlutterSecureStorage storage;
  static const _tokenKey = 'token';

  TokenPreferencesManagerImpl({required this.storage});

  @override
  Future<void> saveToken(Token token) {
    var tokenJson = json.encode(token.toJson());
    return storage.write(key: _tokenKey, value: tokenJson);
  }

  @override
  Future<Token?> getToken() async {
    String? jsonToken = await storage.read(key: _tokenKey);
    if (jsonToken == null) return null;
    return Token.fromJson(json.decode(jsonToken));
  }

}