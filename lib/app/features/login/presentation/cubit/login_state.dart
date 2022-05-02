part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({this.user});

  final UserEntity? user;

  @override
  List get props => [user];

  LoginState copyWith({UserEntity? user}) {
    return LoginState(
      user: user ?? this.user,
    );
  }
}
