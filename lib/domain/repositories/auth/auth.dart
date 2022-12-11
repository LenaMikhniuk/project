import 'package:this_is_project/domain/models/models.dart';

abstract class Auth {
  Future<User> login({required String name, required String password});
  Future<bool> logOut();
}

class AuthImpl implements Auth {
  @override
  Future<bool> logOut() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }

  @override
  Future<User> login({required String name, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return User(name: 'Ola', password: '12345', id: 1);
  }
}
