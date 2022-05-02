import 'package:firebase_auth/firebase_auth.dart';

import 'package:favoritospix/app/features/login/data/repositories/auth_datasource.dart';

class AuthWrapper {
  final AuthDatasource datasource;
  AuthWrapper(this.datasource);
  Future<String> call() async {
    String? _result;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        _result = '/login/';
      } else {
        _result = '/home/';
      }
    });

    return Future.value(_result ?? '/login/');
  }
}
