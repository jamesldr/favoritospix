import 'package:firebase_auth/firebase_auth.dart';

import 'package:favoritospix/app/features/login/data/repositories/auth_datasource.dart';

class AuthWrapper {
  final AuthDatasource datasource;
  AuthWrapper(this.datasource);
  Future<String> call() async {
    User? _result;
    datasource.authStateChanges.listen((event) {}).onData((data) {
      _result = data;
    });

    if (_result != null) {
      return Future.value('/home/');
    } else {
      return Future.value('/login/');
    }
  }
}
