import 'package:favoritospix/app/features/login/presentation/cubit/login_cubit.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/login_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginCubit(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => LoginPage())
  ];
}
