import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favoritospix/app/features/login/data/repositories/auth_datasource.dart';
import 'package:favoritospix/core/data/repositories/favorites_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/details/details_module.dart';
import 'features/form/form_module.dart';
import 'features/home/home_module.dart';
import 'features/login/login_module.dart';
import 'features/welcome/presentation/widgets/auth_wrapper.dart';
import 'features/welcome/welcome_module.dart';
import 'splash/splash_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => FavoritesDatasource(FirebaseFirestore.instance)),
    Bind.lazySingleton((i) => AuthDatasource(FirebaseAuth.instance)),
    Bind.lazySingleton((i) => AuthWrapper(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
    ModuleRoute(
      '/welcome',
      module: WelcomeModule(),
      transition: TransitionType.downToUp,
    ),
    ModuleRoute(
      '/login',
      module: LoginModule(),
      transition: TransitionType.downToUp,
    ),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute(
      '/form',
      module: FormModule(),
      transition: TransitionType.rightToLeft,
    ),
    ModuleRoute(
      '/home/details',
      module: DetailsModule(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
