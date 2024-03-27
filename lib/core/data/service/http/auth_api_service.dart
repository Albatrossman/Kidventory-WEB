import 'package:kidventory_flutter/core/data/model/token_dto.dart';

abstract class AuthApiService {

  Future<TokenDto> signIn(String username, String password);

  Future<Null> signUp();

}