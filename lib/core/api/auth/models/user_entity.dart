part of '../auth_api.dart';

class UserEntity {
  UserEntity({
    this.id,
    this.username,
    this.name,
  });

  final int? id;
  final String? username;
  final String? name;

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      username: json['username'],
      name: json['name'],
    );
  }
}
