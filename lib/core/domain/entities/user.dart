import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;
  final String token;
  final String? password;
  const UserEntity({
    required this.email,
    required this.token,
    this.password,
  });
  @override
  List get props => [email, token, password];

  UserEntity copyWith({
    String? email,
    String? token,
    String? password,
  }) {
    return UserEntity(
      email: email ?? this.email,
      token: token ?? this.token,
      password: password ?? this.password,
    );
  }
}
