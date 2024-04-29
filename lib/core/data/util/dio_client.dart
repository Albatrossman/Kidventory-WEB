import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  final Dio dio = Dio();

  DioClient(String baseUrl, String accessToken) {
    dio.options.baseUrl = baseUrl;
    dio.options.headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      'accept': 'text/plain',
      'Access-Control-Allow-Origin': '*',
    };

    if (kIsWeb) {
      //TODO: Add addaptor for web client
      
      // (dio.httpClientAdapter as HttpClientAdapter).createHttpClient = () =>
      //     HttpClient()
      //       ..badCertificateCallback =
      //           (X509Certificate cert, String host, int port) => true;
    } else {
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
          HttpClient()
            ..badCertificateCallback =
                (X509Certificate cert, String host, int port) => true;
    }
  }
}
