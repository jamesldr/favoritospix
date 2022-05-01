import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/cubit/details_cubit.dart';
import 'presentation/pages/details_page.dart';

class DetailsModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => DetailsCubit())];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: ((_, args) => DetailsPage(model: args.data))),
  ];
}
