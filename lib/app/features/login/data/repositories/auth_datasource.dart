import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favoritospix/core/data/models/favorite_pix_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthDatasource {
  final auth.FirebaseAuth firebaseAuth;
  AuthDatasource(this.firebaseAuth);

  Stream<auth.User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<String> signIn(String email, String password) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((creds) {
        FirebaseFirestore.instance
            .collection('favoritos')
            .doc(creds.user!.uid)
            .set(FavoritePixModel(pixKey: '').toJson());
      });

      return 'Signed In';
    } on auth.FirebaseAuthException {
      rethrow;
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((creds) {
        FirebaseFirestore.instance.collection((creds.user!.uid)).doc().set({});
      });

      return 'Signed Up';
    } on auth.FirebaseAuthException {
      rethrow;
    }
  }
}
