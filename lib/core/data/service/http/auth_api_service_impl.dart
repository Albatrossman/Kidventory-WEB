import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kidventory_flutter/core/data/model/sign_up_dto.dart';
import 'package:kidventory_flutter/core/data/model/token_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:kidventory_flutter/core/data/util/dio_client.dart';

class AuthApiServiceImpl implements AuthApiService {
  final DioClient client;

  AuthApiServiceImpl(this.client);

  @override
  Future<TokenDto> signIn(String username, String password) async {
    Response response = await client.dio
        .post('auth/login', data: {'email': username, 'password': password});

    if (response.statusCode == 200) {
      return TokenDto.fromJson(response.data);
    } else {
      throw Exception('Failed to sign in');
    }
  }

  @override
  Future<Null> signUp(SignUpDto body) async {
    Response response = await client.dio.post('auth/signup', data: body.toJson());

    if (response.statusCode == 200) {
      return null;
    } else {
      throw Exception('Failed to sign up');
    }
  }

  @override
  Future<Null> sendOTP(String email) async {
    final response = await http.post(
      Uri.parse(
          "https://kidventory.aftersearch.com/api/auth/GenerateOtpCode?email=$email"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {}
  }

  @override
  Future<Null> validateOTP(String email, String code) async {
    final response = await http.get(
      Uri.parse(
          "https://kidventory.aftersearch.com/api/auth/ValidateOtpCode?email=$email&code=$code"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {}
  }

  @override
  Future<Null> resetPassword(String email, String code, String password) async {
    final response = await http.patch(
      Uri.parse(
          "https://kidventory.aftersearch.com/api/auth/ResetPassword?email=$email&code=$code&password=$password&"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {}
  }

   @override
  Future<Null> changePassword(String email, String currentPassword, String newPassword, String confirmNewPassword) async {
    final response = await http.patch(
      Uri.parse(
          "https://kidventory.aftersearch.com/api/auth/ChangePassword?email=$email&currentPassword=$currentPassword&newPassword=$newPassword&confirmNewPassword=$confirmNewPassword"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {}
  }
}
