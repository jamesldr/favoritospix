import 'package:auto_size_text/auto_size_text.dart';
import 'package:favoritospix/utils/app_assets.dart';
import 'package:favoritospix/utils/app_colors.dart';
import 'package:favoritospix/utils/app_theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Novo Favorito'),
        backgroundColor: AppTheme.colorScheme.primary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewPadding.vertical,
            child: Column(
              children: [],
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
          ),
          preferredSize: AppBar().preferredSize,
        );
}
