part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.user,
    this.pwVisible = false,
  });

  final UserEntity? user;
  final bool pwVisible;

  @override
  List get props => [user, pwVisible];

  LoginState copyWith({UserEntity? user, bool? pwVisible}) {
    return LoginState(
      user: user ?? this.user,
      pwVisible: pwVisible ?? this.pwVisible,
    );
  }
}
