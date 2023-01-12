import 'package:this_is_project/features/auth/domain/models/models.dart';

abstract class AuthRepositoryAbstract {
  Future<String> login({required String name, required String password});
  Future<bool> logOut();
  Future<User> registerUser(String userName, String password);
}

class MockAuthRepositoryImpl implements AuthRepositoryAbstract {
  @override
  Future<bool> logOut() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }

  @override
  Future<String> login({required String name, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'token_abc_1234';
  }

  @override
  Future<User> registerUser(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return User(name: userName, id: '123', password: password);
  }
}
