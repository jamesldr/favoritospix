import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:favoritospix/core/data/models/favorite_pix_model.dart';
import 'package:favoritospix/core/data/repositories/favorites_datasource.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(const DetailsState());
  final repository = FavoritesDatasource(FirebaseFirestore.instance);

  Future getFavoriteStream(FavoritePixModel model) async {
    repository.getFavoriteById(model.id!).listen((event) {
      emit(state.copyWith(model: event as FavoritePixModel));
    });
  }
}
