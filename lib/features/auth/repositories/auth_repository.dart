import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../core/api/api.dart';
import '../../../core/api/auth/auth_api.dart';
import '../../../core/errors/failure.dart';
import '../models/user.dart';

enum AuthState { unauthenticated, loading, authenticated }

class AuthRepository {
  AuthRepository() : _controller = StreamController<AuthState>();

  final FlutterSecureStorage _localStorage = Get.find();
  final AuthApi _authApi = Get.put(AuthApi());
  final StreamController<AuthState> _controller;

  static const tokenKey = '_token';

  Stream<AuthState> get status async* {
    yield* _controller.stream;
  }

  Future<Either<Failure, bool>> login(String username, String password) async {
    try {
      final response = await _authApi.login(username, password);

      await _localStorage.write(key: tokenKey, value: response.token);

      _controller.add(AuthState.authenticated);

      return const Right(true);
    } on ApiException catch (e) {
      return Left(Failure(e.message));
    }
  }

  Future<void> logout() async {
    await _localStorage.delete(key: '_token');

    _controller.add(AuthState.unauthenticated);
  }

  Future<String?> getAuthenticationToken() async {
    return await _localStorage.read(key: tokenKey);
  }

  Future<Either<Failure, User?>> getAuthenticatedUser() async {
    try {
      var token = await getAuthenticationToken() ?? '';

      final response = await _authApi.getAuthUser(token);

      return Right(User.fromEntity(response));
    } on ApiException catch (e) {
      return Left(Failure(e.message));
    }
  }

  void dispose() => _controller.close();
}
