import 'package:this_is_project/domain/models/auth_model/user.dart';
import 'package:this_is_project/domain/repositories/auth/auth.dart';

class AuthImpl implements Auth {
  @override
  Future<bool> logOut() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }

  @override
  Future<User> login() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return User(name: 'Ola', email: 'ola123', id: 1);
  }
}
