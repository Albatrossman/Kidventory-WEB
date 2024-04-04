import 'dart:convert';

import 'package:kidventory_flutter/core/data/model/token_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/auth_api_service.dart';
import 'package:http/http.dart' as http;

class AuthApiServiceImpl implements AuthApiService {

  @override
  Future<TokenDto> signIn(String username, String password) async {
    final response = await http.get(
      Uri.parse("https://kidventory.aftersearch.com/api/auth/login?email=$username&password=$password"),
      headers: {'Content-Type': 'application/json'}
    );

    if (response.statusCode == 200) {
      return TokenDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to sign in');
    }
  }

  @override
  Future<Null> signUp() {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}