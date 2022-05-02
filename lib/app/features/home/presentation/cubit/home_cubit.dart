import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:favoritospix/app/features/login/data/repositories/auth_datasource.dart';
import 'package:favoritospix/core/data/models/favorite_pix_model.dart';
import 'package:favoritospix/core/data/repositories/favorites_datasource.dart';
import 'package:favoritospix/core/domain/entities/favorite_pix.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  final repository = FavoritesDatasource(FirebaseFirestore.instance);
  final auth = AuthDatasource(FirebaseAuth.instance);

  Future getFavorites() async {
    repository.getFavorites().listen(
      (event) {
        emit(state.copyWith(favorites: event));
      },
    );
  }

  removeFavorite(FavoritePixModel model) async {
    await repository.removeFavorite(model);
  }

  Future signout() async {
    await Modular.to.pushReplacementNamed('/welcome/');
    return await auth.singOut();
  }
}
