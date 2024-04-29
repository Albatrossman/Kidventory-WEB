import 'package:kidventory_flutter/core/data/model/sign_up_dto.dart';
import 'package:kidventory_flutter/core/data/model/token_dto.dart';

abstract class AuthApiService {
  Future<TokenDto> signIn(String username, String password);

  Future<Null> signUp(SignUpDto body);

  Future<Null> sendOTP(String email);
  Future<Null> validateOTP(String email, String code);
  Future<Null> resetPassword(String email, String code, String password);
  Future<Null> changePassword(String email, String currentPassword, String newPassword, String confirmNewPassword);
}
