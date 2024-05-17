import 'package:kidventory_flutter/core/data/model/delete_account_dto.dart';
import 'package:kidventory_flutter/core/data/model/sign_up_dto.dart';
import 'package:kidventory_flutter/core/data/model/token_dto.dart';
import 'package:kidventory_flutter/core/data/model/update_password_dto.dart';

abstract class AuthApiService {
  Future<TokenDto> signIn(String username, String password);

  Future<void> signUp(SignUpDto body);

  Future<void> sendOTP(String email);

  Future<void> validateOTP(String email, String code);

  Future<void> resetPassword(String email, String code, String password);

  Future<void> changePassword(UpdatePasswordDto body);

  Future<void> deleteAccount(DeleteAccountDto body);
}
