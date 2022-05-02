import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favoritospix/core/data/models/favorite_pix_model.dart';
import 'package:favoritospix/core/domain/entities/favorite_pix.dart';
import 'package:favoritospix/core/domain/repositories/favorites_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesDatasource implements FavoritesRepository {
  FavoritesDatasource(this.firestore);
  final FirebaseFirestore firestore;

  final _path = (FirebaseAuth.instance.currentUser!.uid);
  @override
  Stream<List<FavoritePix>> getFavorites() {
    return firestore.collection(_path).snapshots().map((query) {
      return query.docs.map((e) => FavoritePixModel.fromJson(e)).toList();
    });
  }

  @override
  Future addFavorite(FavoritePix model) async {
    model as FavoritePixModel;
    await firestore.collection(_path).doc(model.id).set(model.toJson());
  }

  @override
  Future removeFavorite(FavoritePix model) async {
    model as FavoritePixModel;
    await firestore.collection(_path).doc(model.id).delete();
  }

  @override
  Future updateFavorite(FavoritePix model) async {
    model as FavoritePixModel;
    await firestore.collection(_path).doc(model.id).update(model.toJson());
  }

  @override
  Stream<FavoritePix> getFavoriteById(String id) {
    return firestore.collection(_path).doc(id).snapshots().map((query) {
      return FavoritePixModel.fromJson(query);
    });
  }
}
