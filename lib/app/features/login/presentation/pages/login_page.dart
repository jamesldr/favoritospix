import 'package:favoritospix/utils/app_assets.dart';

import 'package:favoritospix/utils/app_form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:favoritospix/core/presentation/widgets/app_scaffold.dart';
import 'package:favoritospix/utils/app_colors.dart';

import '../cubit/login_cubit.dart';

enum PixKeyType { email, cpfCnpj, celular }

class LoginPage extends StatelessWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final LoginCubit cubit = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: AppScaffoldBody(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewInsets.bottom,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Spacer(),
                  const LoginHeader(),
                  const Spacer(),
                  LoginForm(),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppImages.pixLogo(),
        Text(
          'Favoritos Pix',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final LoginCubit cubit = Modular.get();

  final inputDecoration = InputDecoration(
    border: const OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.bgColor.withOpacity(0.5),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  onChanged: cubit.emailOnChanged,
                  validator: AppFormValidator.email,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: inputDecoration.copyWith(
                    label: const Text('Email'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: BlocBuilder(
                  bloc: cubit,
                  builder: (context, LoginState state) {
                    return TextFormField(
                      onChanged: cubit.passwordOnChanged,
                      validator: cubit.passwordValidator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: !(state.pwVisible),
                      decoration: inputDecoration.copyWith(
                        label: const Text('Senha'),
                        suffixIcon: IconButton(
                          onPressed: cubit.toggleVisibility,
                          icon: Icon(
                            state.pwVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            cubit.login(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Login/Cadastro'.toUpperCase(),
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
