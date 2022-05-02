import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

import 'package:favoritospix/app/features/login/login_module.dart';

void main() {
  setUpAll(() {
    initModule(LoginModule());
  });
}
