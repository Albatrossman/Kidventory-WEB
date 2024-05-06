import 'package:kidventory_flutter/core/domain/model/token.dart';

abstract class TokenPreferencesManager {

  Future<void> saveToken(Token token);

  Future<Token?> getToken();

  Future<void> clearToken();

}