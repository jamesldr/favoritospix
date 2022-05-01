import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:favoritospix/core/data/models/favorite_pix_model.dart';
import 'package:favoritospix/core/domain/repositories/favorites_repository.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this.repository) : super(const DetailsState());
  final FavoritesRepository repository;

  Future getFavoriteStream(FavoritePixModel model) async {
    repository.getFavoriteById(model.id!).listen((event) {
      emit(state.copyWith(model: event as FavoritePixModel));
    });
  }
}
