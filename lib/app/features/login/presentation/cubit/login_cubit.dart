import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:favoritospix/core/domain/entities/user.dart';
import 'package:favoritospix/utils/app_colors.dart';
import 'package:favoritospix/utils/app_form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/repositories/auth_datasource.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.repository) : super(const LoginState());

  final AuthDatasource repository;

  String? passwordValidator(String? v) {
    final _result = notEmptyValidator(v);
    if ((v?.length ?? 0) < 8) {
      return 'Senha requer pelo menos 8 caracteres';
    }
    return _result;
  }

  String? notEmptyValidator(String? v) {
    if (v?.isEmpty ?? true) {
      return 'Campo requerido';
    }
    return null;
  }

  void emailOnChanged(String? value) {
    emit(state.copyWith(
        user: state.user?.copyWith(email: value) ??
            UserEntity(email: value ?? '', token: '')));
  }

  void passwordOnChanged(String? value) {
    emit(state.copyWith(
        user: state.user?.copyWith(password: value) ??
            UserEntity(password: value ?? '', token: '', email: '')));
  }

  void login(BuildContext context) async {
    bool _pass = false;
    if (passwordValidator(state.user?.password) == null) {
      _pass = true;
    } else {
      _pass = false;
    }
    if (AppFormValidator.email(state.user?.email) == null) {
      _pass = true;
    } else {
      _pass = false;
    }

    if (_pass) {
      await repository.signIn(state.user!.email, state.user!.password!).then(
        (value) {
          return Modular.to.pushReplacementNamed('/home/');
        },
      ).onError(
        (error, stackTrace) async {
          await repository
              .signUp(state.user!.email, state.user!.password!)
              .then(
            (value) {
              return Modular.to.pushReplacementNamed('/home/');
            },
          ).onError(
            (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.bgColor,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login inválido",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          return null;
        },
      );
    }
  }
}
