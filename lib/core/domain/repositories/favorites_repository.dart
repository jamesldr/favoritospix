import 'package:favoritospix/core/data/models/favorite_pix_model.dart';
import 'package:favoritospix/core/domain/entities/favorite_pix.dart';

abstract class FavoritesRepository {
  // Future<List<FavoritePix>>
  Stream<List<FavoritePix>> getFavorites();

  Future addFavorite(FavoritePix model);
  Future removeFavorite(FavoritePix model);
  Future updateFavorite(FavoritePix model);
}
