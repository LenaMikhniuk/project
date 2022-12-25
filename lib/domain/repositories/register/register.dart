import 'package:this_is_project/domain/models/auth_model/user.dart';

abstract class Register {
  Future<User> registerUser(String userName, String password);
}

class MockRegister implements Register {
  @override
  Future<User> registerUser(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 3));
    return User(name: userName, id: 123, password: password);
  }
}
