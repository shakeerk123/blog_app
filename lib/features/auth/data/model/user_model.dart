import 'package:blog_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.email,
    required super.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['id'] ?? ' ',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
