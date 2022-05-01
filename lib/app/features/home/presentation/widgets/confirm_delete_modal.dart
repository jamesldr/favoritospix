import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:favoritospix/app/features/form/presentation/pages/form_page.dart';
import 'package:favoritospix/utils/app_colors.dart';

class ConfirmDeleteModal extends StatelessWidget {
  const ConfirmDeleteModal({
    Key? key,
  }) : super(key: key);

  Future<bool> show(BuildContext context) async {
    bool _result = false;
    _result = await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      builder: (_) => build(context),
    );
    return _result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Excluir Chave',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: AppColors.bgColor,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Você tem certeza que deseja excluir esta chave?',
            style: GoogleFonts.montserrat(fontSize: 16),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('Não')),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Sim')),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    required this.item,
    this.icon,
    required this.type,
  }) : super(key: key);
  final String item;
  final IconData? icon;
  final PixKeyType type;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed('/form/', arguments: type);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon ?? Icons.key, color: AppColors.bgColor),
              const SizedBox(width: 8),
              Expanded(child: Text(item)),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.bgColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
