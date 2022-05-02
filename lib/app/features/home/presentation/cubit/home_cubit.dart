import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:favoritospix/core/data/models/favorite_pix_model.dart';
import 'package:favoritospix/core/data/repositories/favorites_datasource.dart';

import 'package:favoritospix/core/domain/entities/favorite_pix.dart';
import 'package:favoritospix/core/domain/repositories/favorites_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  final FavoritesRepository repository =
      FavoritesDatasource(FirebaseFirestore.instance);

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
}
