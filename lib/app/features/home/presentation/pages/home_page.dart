import 'package:auto_size_text/auto_size_text.dart';
import 'package:favoritospix/app/features/home/presentation/cubit/home_cubit.dart';
import 'package:favoritospix/app/features/home/presentation/widgets/add_pix_key_modal.dart';
import 'package:favoritospix/app/features/home/presentation/widgets/favorite_list_item.dart';
import 'package:favoritospix/app/features/home/presentation/widgets/home_page_header_card.dart';
import 'package:favoritospix/core/presentation/widgets/app_scaffold.dart';

import 'package:favoritospix/utils/app_assets.dart';
import 'package:favoritospix/utils/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeCubit cubit = Modular.get();

  @override
  void initState() {
    cubit.getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => const AddPixKeyModal().show(context),
        icon: const Icon(Icons.add),
        label: const Text('Novo Favorito'),
        backgroundColor: AppTheme.colorScheme.primary,
      ),
      body: AppScaffoldBody(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder(
                    bloc: cubit,
                    builder: (context, HomeState state) {
                      return Column(
                        children: [
                          HomePageHeaderCard(favorites: state.favorites ?? []),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.favorites?.length ?? 0,
                            itemBuilder: (_, i) {
                              final _model = state.favorites![i];
                              return FavoriteListItem(model: _model);
                            },
                          ),
                        ],
                      );
                    }),
                SizedBox(height: AppBar().preferredSize.height * 1.1)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends PreferredSize {
  _AppBar()
      : super(
          child: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppImages.pixLogo(const Size.square(18)),
                const SizedBox(width: 8),
                const AutoSizeText(
                  'Favoritos Pix',
                  maxLines: 1,
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () async => (FirebaseAuth.instance.signOut()).then(
                  (v) => Modular.to.pushReplacementNamed('/welcome/'),
                ),
                icon: const Icon(Icons.logout),
              )
            ],
          ),
          preferredSize: AppBar().preferredSize,
        );
}
