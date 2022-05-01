import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:favoritospix/core/data/models/favorite_pix_model.dart';
import 'package:favoritospix/core/data/repositories/favorites_datasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'form_page_state.dart';

class FormCubit extends Cubit<FormPageState> {
  FormCubit(this.repository) : super(const FormPageState());

  final FavoritesDatasource repository;

  nameOnChanged(String? v) => emit(state.copyWith(name: v));
  docOnChanged(String? v) => emit(state.copyWith(cpfCnpj: v));
  branchOnChanged(String? v) => emit(state.copyWith(bankBranch: v));
  accountOnChanged(String? v) => emit(state.copyWith(bankAccount: v));
  bankOnChanged(String? v) => emit(state.copyWith(bankName: v));
  keyOnChanged(String? v) => emit(state.copyWith(pixKey: v));

  Future onSave(FormState? formState) async {
    if (formState?.validate() ?? false) {
      final _model = FavoritePixModel(
        name: state.name,
        pixKey: state.pixKey!,
        cpfCnpj: state.cpfCnpj,
        bankBranch: state.bankBranch,
        bankNumber: state.bankAccount,
        bankName: state.bankName,
        registerDate: DateTime.now(),
        lastUpdate: DateTime.now(),
      );
      await repository.addFavorite(_model);
      Modular.to.pop();
    }
  }

  Future onEdit(FormState? currentState, FavoritePixModel model) async {
    final _model = FavoritePixModel(
      id: model.id,
      name: state.name ?? model.name,
      pixKey: state.pixKey ?? model.pixKey,
      cpfCnpj: state.cpfCnpj ?? model.cpfCnpj,
      bankBranch: state.bankBranch ?? model.bankBranch,
      bankNumber: state.bankAccount ?? model.bankNumber,
      bankName: state.bankName ?? model.bankName,
      registerDate: model.registerDate,
      lastUpdate: DateTime.now(),
    );
    await repository.updateFavorite(_model);
    Modular.to.pop();
  }
}
