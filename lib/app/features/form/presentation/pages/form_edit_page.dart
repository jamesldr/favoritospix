import 'package:brasil_fields/brasil_fields.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:favoritospix/app/features/form/presentation/cubit/form_cubit.dart';
import 'package:favoritospix/core/data/models/favorite_pix_model.dart';
import 'package:favoritospix/core/presentation/widgets/app_scaffold.dart';
import 'package:favoritospix/utils/app_colors.dart';

class FormEditPage extends StatelessWidget {
  FormEditPage({
    Key? key,
    required this.model,
  }) : super(key: key);

  final FormCubit cubit = Modular.get();
  final FavoritePixModel model;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var inputDecoration = InputDecoration(
      border: const OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.bgColor.withOpacity(0.5),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Favorito"),
      ),
      body: AppScaffoldBody(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      initialValue: model.name,
                      decoration: inputDecoration.copyWith(
                        label: const Text('Nome do contato'),
                      ),
                      onChanged: cubit.nameOnChanged,
                      validator: _notEmptyValidator,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      initialValue: model.cpfCnpj,
                      decoration: inputDecoration.copyWith(
                        label: const Text('CPF/CNPJ'),
                      ),
                      onChanged: cubit.docOnChanged,
                      validator: _notEmptyValidator,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfOuCnpjFormatter()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      initialValue: model.bankBranch,
                      decoration: inputDecoration.copyWith(
                        label: const Text('Agência'),
                      ),
                      onChanged: cubit.branchOnChanged,
                      validator: _notEmptyValidator,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TextInputMask(mask: ['9999', '9999-9', '9999-99'])
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      initialValue: model.bankNumber,
                      decoration: inputDecoration.copyWith(
                        label: const Text('Conta'),
                      ),
                      onChanged: cubit.accountOnChanged,
                      validator: _notEmptyValidator,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TextInputMask(mask: [
                          '99999-9',
                          '999999-9',
                          '9999999-9',
                          '99999999-9',
                          '999999999-9',
                          '9999999999-9',
                          '99999999999-9',
                        ])
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      initialValue: model.bankName,
                      decoration: inputDecoration.copyWith(
                        label: const Text('Banco'),
                      ),
                      onChanged: cubit.bankOnChanged,
                      validator: _notEmptyValidator,
                      inputFormatters: const [],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      initialValue: model.pixKey,
                      decoration: inputDecoration.copyWith(
                        label: const Text('Chave Pix'),
                      ),
                      enabled: false,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                              onPressed: () {
                                cubit
                                    .onEdit(formKey.currentState, model)
                                    .then((value) =>
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: AppColors.bgColor,
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Favorito editado com sucesso",
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                    .onError((error, stackTrace) =>
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: AppColors.bgColor,
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Falha ao editar favorito",
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Salvar'.toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _notEmptyValidator(String? v) {
    if (v?.isEmpty ?? true) {
      return 'Campo requerido';
    }
    return null;
  }
}
