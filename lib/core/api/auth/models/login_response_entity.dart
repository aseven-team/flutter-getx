part of '../auth_api.dart';

class LoginResponseEntity {
  LoginResponseEntity({
    this.token,
    this.user,
  });

  final String? token;
  final UserEntity? user;

  factory LoginResponseEntity.fromJsoon(Map<String, dynamic> json) =>
      LoginResponseEntity(
        token: json['token'],
        user: json['user'] != null ? UserEntity.fromJson(json['user']) : null,
      );
}
