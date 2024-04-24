import 'dart:convert';

import 'package:kidventory_flutter/core/data/model/sign_up_dto.dart';
import 'package:kidventory_flutter/core/data/model/token_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:http/http.dart' as http;

class AuthApiServiceImpl implements AuthApiService {
  @override
  Future<TokenDto> signIn(String username, String password) async {
    final response = await http.get(
      Uri.parse("https://kidventory.aftersearch.com/api/auth/login?email=$username&password=$password"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return TokenDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to sign in');
    }
  }

  @override
  Future<Null> signUp(SignUpDto body) async {
    final response = await http.post(
      Uri.parse("https://kidventory.aftersearch.com/api/auth/signup"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body.toJson()),
    );

    if (response.statusCode == 200) {

    }
  }

  @override
  Future<Null> sendOTP(String email) async {
    final response = await http.post(
      Uri.parse("https://kidventory.aftersearch.com/api/auth/GenerateOtpCode?email=$email"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {

    }
  }

  @override
  Future<Null> validateOTP(String email, String code) async {
    final response = await http.get(
      Uri.parse("https://kidventory.aftersearch.com/api/auth/ValidateOtpCode?email=$email&code=$code"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {

    }
  }

  @override
  Future<Null> resetPassword(String email, String code, String password) async {
    final response = await http.post(
      Uri.parse("https://kidventory.aftersearch.com/api/auth/ResetPassword?email=$email&code=$code&password=$password&"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {

    }
  }
}
