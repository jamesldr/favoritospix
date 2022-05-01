import 'package:auto_size_text/auto_size_text.dart';
import 'package:favoritospix/core/domain/entities/favorite_pix.dart';
import 'package:favoritospix/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvatarWidget extends StatelessWidget {
  final FavoritePix model;
  const AvatarWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  String get _getAcronym {
    final _names = model.name?.split(' ');
    late String _result;

    if (_names?.isNotEmpty ?? false) {
      final _length = _names?.length ?? 0;
      if (_length > 1) {
        _result = (_names?[0].substring(0, 1).toUpperCase().toString() ?? '') +
            (_names?[1].substring(0, 1).toUpperCase().toString() ?? '');
      } else {
        _result = (_names?[0].substring(0, 1).toUpperCase().toString() ?? '') +
            (_names?[0].substring(1, 2).toLowerCase().toString() ?? '');
      }
    } else {
      _result = '??';
    }
    return _result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.bgColor,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: AutoSizeText(
            _getAcronym,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
      ),
    );
  }
}
