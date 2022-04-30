import 'package:flutter_modular/flutter_modular.dart';

import 'features/home/home_module.dart';
import 'features/welcome/welcome_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: WelcomeModule()),
    ModuleRoute('/home', module: HomeModule()),
  ];
}
