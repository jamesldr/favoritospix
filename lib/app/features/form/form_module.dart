import 'package:favoritospix/app/features/form/presentation/cubit/form_cubit.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/form_edit_page.dart';
import 'presentation/pages/form_page.dart';

class FormModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => FormCubit(i()))];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => FormPage(type: args.data)),
    ChildRoute(
      '/edit/',
      child: (_, args) => FormEditPage(model: args.data),
      transition: TransitionType.fadeIn,
    )
  ];
}
