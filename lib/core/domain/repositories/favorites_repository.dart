import 'package:favoritospix/core/domain/entities/favorite_pix.dart';

abstract class FavoritesRepository {
  // Future<List<FavoritePix>>
  Stream<List<FavoritePix>> getFavorites();
  Stream<FavoritePix> getFavoriteById(String id);

  Future addFavorite(FavoritePix model);
  Future removeFavorite(FavoritePix model);
  Future updateFavorite(FavoritePix model);
}
