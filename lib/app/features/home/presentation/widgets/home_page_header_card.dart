import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:favoritospix/core/domain/entities/favorite_pix.dart';
import 'package:favoritospix/utils/app_colors.dart';

class HomePageHeaderCard extends StatelessWidget {
  const HomePageHeaderCard({
    Key? key,
    required this.favorites,
  }) : super(key: key);

  final List<FavoritePix> favorites;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AutoSizeText(
              'Chaves Pix Armazenadas:',
              maxLines: 1,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(flex: 1),
                Flexible(
                  flex: 1,
                  child: AutoSizeText(
                    favorites.length.toString(),
                    maxLines: 1,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 64,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
