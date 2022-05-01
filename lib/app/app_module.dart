import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favoritospix/core/data/repositories/favorites_datasource.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/details/details_module.dart';
import 'features/form/form_module.dart';
import 'features/home/home_module.dart';
import 'features/welcome/welcome_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => FavoritesDatasource(FirebaseFirestore.instance))
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: WelcomeModule()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute(
      '/form',
      module: FormModule(),
      transition: TransitionType.rightToLeft,
    ),
    ModuleRoute(
      '/home/details',
      module: DetailsModule(),
      transition: TransitionType.downToUp,
    ),
  ];
}
