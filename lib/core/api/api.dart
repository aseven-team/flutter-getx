import 'package:dio/dio.dart';

abstract class BaseApi {
  final httpClient = Dio(
    BaseOptions(
      baseUrl: 'https://example.com',
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  ApiException createApiException(DioError error) {
    dynamic message = 'Terjadi kesalahan, silakan coba beberapa saat lagi.';

    if (error.type == DioErrorType.response) {
      message = error.response?.data['message'];
    }

    return ApiException(message);
  }
}

class ApiException implements Exception {
  dynamic message;

  ApiException(this.message);
}
