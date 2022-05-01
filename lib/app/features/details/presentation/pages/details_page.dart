import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:favoritospix/core/data/models/favorite_pix_model.dart';
import 'package:favoritospix/core/presentation/widgets/app_scaffold.dart';
import 'package:favoritospix/utils/app_colors.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    required this.model,
  }) : super(key: key);
  final FavoritePixModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações do contato'),
        actions: [
          IconButton(
              onPressed: () {
                Modular.to.pushNamed('/form/edit/', arguments: model);
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: AppScaffoldBody(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                Center(
                  child: Text(
                    model.name ?? '',
                    style: GoogleFonts.montserrat(
                      color: AppColors.bgColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0)
                      .copyWith(top: 16),
                  child: _Row(label: 'CPF/CNPJ:', value: model.cpfCnpj ?? ''),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Informações Bancárias',
                          style: GoogleFonts.montserrat(
                            color: AppColors.bgColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0)
                              .copyWith(top: 16),
                          child: _Row(
                              label: 'Banco:', value: model.bankName ?? ''),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0)
                              .copyWith(top: 16),
                          child: _Row(
                              label: 'Agencia:', value: model.bankBranch ?? ''),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0)
                              .copyWith(top: 16),
                          child: _Row(
                              label: 'Conta:', value: model.bankNumber ?? ''),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            'Chave PIX',
                            style: GoogleFonts.montserrat(
                              color: AppColors.bgColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: Text(
                            model.pixKey,
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () => _copyKey(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.copy),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Copiar chave'.toUpperCase(),
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _copyKey(BuildContext context) {
    Clipboard.setData(ClipboardData(text: model.pixKey)).then(
      (value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.bgColor,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Chave PIX copiada com sucesso",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: AppColors.bgColor,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.montserrat(),
        ),
      ],
    );
  }
}
