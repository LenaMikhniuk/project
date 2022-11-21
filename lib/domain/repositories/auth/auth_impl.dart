import 'package:this_is_project/domain/models/auth_model/user.dart';
import 'package:this_is_project/domain/repositories/auth/auth.dart';

class AuthImpl implements Auth {
  @override
  bool logOut() {
    return true;
  }

  @override
  User? login() {
    if (isValidatedUser()) {
      return User(email: '', id: 1, name: '');
    } else {
      return null;
    }
  }

  @override
  bool isValidatedUser() {
    return true;
  }
}
