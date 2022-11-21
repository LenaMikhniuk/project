import '../../models/auth_model/user.dart';

abstract class Auth {
  User? login();
  bool isValidatedUser();
  bool logOut();
}
