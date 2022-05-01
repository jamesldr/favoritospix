import 'package:auto_size_text/auto_size_text.dart';
import 'package:favoritospix/app/features/home/presentation/cubit/home_cubit.dart';
import 'package:favoritospix/app/features/home/presentation/widgets/confirm_delete_modal.dart';
import 'package:favoritospix/core/data/models/favorite_pix_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:favoritospix/core/domain/entities/favorite_pix.dart';
import 'package:favoritospix/utils/app_colors.dart';

import 'avatar_widget.dart';

class FavoriteListItem extends StatelessWidget {
  FavoriteListItem({
    Key? key,
    required this.model,
    this.onTap,
  }) : super(key: key);

  final FavoritePix model;
  final Function(FavoritePix)? onTap;
  final HomeCubit cubit = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (d) async {
        if (d == DismissDirection.endToStart) {
          final _result = await const ConfirmDeleteModal().show(context);
          if (_result) {
            cubit.removeFavorite(model as FavoritePixModel);
          }
        }
        return Future.value(false);
      },
      child: InkWell(
        onTap: () {
          Modular.to.pushNamed('/home/details/', arguments: model);
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                AvatarWidget(model: model),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AutoSizeText(
                        model.name ?? '',
                        style: GoogleFonts.montserrat(
                          color: AppColors.bgColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          AutoSizeText(
                            'Banco:',
                            style: GoogleFonts.montserrat(),
                          ),
                          const SizedBox(width: 8),
                          AutoSizeText(
                            model.bankName ?? '',
                            style: GoogleFonts.montserrat(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.bgColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
