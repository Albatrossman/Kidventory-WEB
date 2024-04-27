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
    Response response = await client.dio.post(
        'auth/login',
        data: { 'email': username, 'password': password }
    );

    if (response.statusCode == 200) {
      return TokenDto.fromJson(response.data);
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
}
