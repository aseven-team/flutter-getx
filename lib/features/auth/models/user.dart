import '../../../core/api/auth/auth_api.dart';

class User {
  User({
    required this.username,
    required this.name,
  });

  final String username;
  final String name;

  factory User.fromEntity(UserEntity entity) {
    return User(
      username: entity.username ?? '-',
      name: entity.name ?? '-',
    );
  }
}
