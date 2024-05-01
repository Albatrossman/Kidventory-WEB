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

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          if (error.response != null) {
            // If the response has data and it contains an "error" field,
            // throw the error message back instead of using the default DioException.
            final responseData = error.response!.data;
            if (responseData is Map && responseData.containsKey('error')) {
              final errorMessage = responseData['error'];
              throw DioException(
                requestOptions: error.requestOptions,
                response: error.response,
                type: error.type,
                error: error.response?.statusCode!.toString(),
                message: errorMessage,
              );
            }
          }
          // If the error doesn't match the custom condition, just let it pass through.
          handler.next(error);
        },
      ),
    );
  }
}
