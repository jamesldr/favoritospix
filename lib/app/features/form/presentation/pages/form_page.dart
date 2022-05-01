import 'package:brasil_fields/brasil_fields.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:favoritospix/app/features/form/presentation/cubit/form_cubit.dart';
import 'package:favoritospix/utils/app_form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:favoritospix/core/presentation/widgets/app_scaffold.dart';
import 'package:favoritospix/utils/app_colors.dart';

enum PixKeyType { email, cpfCnpj, celular }

class FormPage extends StatelessWidget {
  FormPage({
    Key? key,
    required this.type,
  }) : super(key: key);

  final PixKeyType type;
  final FormCubit cubit = Modular.get();

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
                      decoration: inputDecoration.copyWith(
                        label: const Text('Nome do contato'),
                      ),
                      onChanged: cubit.nameOnChanged,
                      validator: _notEmptyValidator,
                    ),
                  ),
                  Visibility(
                    visible: type != PixKeyType.cpfCnpj,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
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
                      decoration: inputDecoration.copyWith(
                        label: const Text('Chave Pix'),
                      ),
                      onChanged: cubit.keyOnChanged,
                      inputFormatters: [..._formatterByType()],
                      validator: _getValidation,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                              onPressed: () =>
                                  cubit.onSave(formKey.currentState),
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

  List _formatterByType() {
    switch (type) {
      case PixKeyType.celular:
        return [
          TextInputMask(
            mask: ['\\+99 (99) 9 9999-9999'],
          )
        ];
      case PixKeyType.cpfCnpj:
        return [FilteringTextInputFormatter.digitsOnly, CpfOuCnpjFormatter()];
      case PixKeyType.email:
        return [];
      default:
        return [];
    }
  }

  String? _getValidation(String? value) {
    switch (type) {
      case PixKeyType.email:
        return AppFormValidator.email(value);
      case PixKeyType.cpfCnpj:
        return AppFormValidator.cpfOrCnpj(value);
      case PixKeyType.celular:
        return AppFormValidator.phone(value);
      default:
    }
    return null;
  }

  String? _notEmptyValidator(String? v) {
    if (v?.isEmpty ?? true) {
      return 'Campo requerido';
    }
    return null;
  }
}
