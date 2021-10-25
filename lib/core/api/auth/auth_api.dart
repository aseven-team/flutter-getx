import 'package:dio/dio.dart';

import '../api.dart';

part './models/login_response_entity.dart';
part './models/user_entity.dart';

class AuthApi extends BaseApi {
  /// Login
  ///
  /// `POST /api/login`
  Future<LoginResponseEntity> login(String username, String password) async {
    try {
      final response = await httpClient.post(
        '/api/login',
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      return LoginResponseEntity.fromJsoon(response.data['data']);
    } on DioError catch (e) {
      throw createApiException(e);
    }
  }

  /// Get Authenticated User
  ///
  /// `GET /api/users/profile`
  Future<UserEntity> getAuthUser(String token) async {
    try {
      final response = await httpClient.get(
        '/api/users/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return UserEntity.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw createApiException(e);
    }
  }
}
