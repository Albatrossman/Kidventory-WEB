import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio();

  DioClient(String baseUrl, String accessToken) {
    dio.options.baseUrl = baseUrl;
    dio.options.headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
  }
}