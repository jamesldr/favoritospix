import 'package:favoritospix/utils/data_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:favoritospix/core/data/models/favorite_pix_model.dart';
import 'package:favoritospix/core/presentation/widgets/app_scaffold.dart';
import 'package:favoritospix/utils/app_colors.dart';

import '../cubit/details_cubit.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
    required this.model,
  }) : super(key: key);
  final FavoritePixModel model;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DetailsCubit cubit = Modular.get();

  @override
  void initState() {
    cubit.getFavoriteStream(widget.model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações do contato'),
        actions: [
          BlocBuilder(
            bloc: cubit,
            builder: (_, DetailsState state) {
              return IconButton(
                onPressed: () {
                  Modular.to.pushNamed('/form/edit/', arguments: state.model);
                },
                icon: const Icon(Icons.edit),
              );
            },
          )
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
                BlocBuilder(
                  bloc: cubit,
                  builder: (context, DetailsState state) {
                    return Center(
                      child: Text(
                        state.model?.name ?? '',
                        style: GoogleFonts.montserrat(
                          color: AppColors.bgColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    );
                  },
                ),
                BlocBuilder(
                  bloc: cubit,
                  builder: (context, DetailsState state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0)
                          .copyWith(top: 16),
                      child: _Row(
                          label: 'CPF/CNPJ:',
                          value: state.model?.cpfCnpj ?? ''),
                    );
                  },
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
                          child: BlocBuilder(
                            bloc: cubit,
                            builder: (context, DetailsState state) {
                              return _Row(
                                  label: 'Banco:',
                                  value: state.model?.bankName ?? '');
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0)
                              .copyWith(top: 16),
                          child: BlocBuilder(
                            bloc: cubit,
                            builder: (context, DetailsState state) {
                              return _Row(
                                  label: 'Agencia:',
                                  value: state.model?.bankBranch ?? '');
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0)
                              .copyWith(top: 16),
                          child: BlocBuilder(
                            bloc: cubit,
                            builder: (context, DetailsState state) {
                              return _Row(
                                  label: 'Conta:',
                                  value: state.model?.bankNumber ?? '');
                            },
                          ),
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
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: BlocBuilder(
                            bloc: cubit,
                            builder: (context, DetailsState state) {
                              return Text(
                                state.model?.pixKey ?? '',
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
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
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Registro de Favorito',
                            style: GoogleFonts.montserrat(
                              color: AppColors.bgColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0)
                              .copyWith(top: 16),
                          child: BlocBuilder(
                            bloc: cubit,
                            builder: (context, DetailsState state) {
                              return _Row(
                                label: 'Criado em:',
                                value: DataFormatters.formatDate(
                                  state.model?.registerDate ??
                                      widget.model.registerDate!,
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0)
                              .copyWith(top: 16),
                          child: BlocBuilder(
                            bloc: cubit,
                            builder: (context, DetailsState state) {
                              return _Row(
                                label: 'Atualizado em:',
                                value: DataFormatters.formatDate(
                                    state.model?.lastUpdate ??
                                        widget.model.lastUpdate!),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _copyKey(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.model.pixKey))
        .then(
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
        )
        .onError(
            (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.bgColor,
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Não foi possível copiar Chave PIX",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
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
