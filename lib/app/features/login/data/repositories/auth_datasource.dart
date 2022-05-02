import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDatasource {
  final FirebaseAuth firebaseAuth;

  final _firestore = FirebaseFirestore.instance;
  AuthDatasource(this.firebaseAuth);

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<String> signIn(String email, String password) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((creds) async {
        _firestore.collection(creds.user!.uid).doc();

        // .set(FavoritePixModel(pixKey: '').toJson());
      });

      return 'Signed In';
    } on FirebaseAuthException {
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
          .then((creds) async {
        _firestore.collection((creds.user!.uid)).doc();
      });

      return 'Signed Up';
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future singOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
