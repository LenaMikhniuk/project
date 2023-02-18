import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepositoryAbstract {
  Future<void> login({required String email, required String password});
  Future<void> logOut();
  Future<void> registerUser(String email, String password);
}

class MockAuthRepositoryImpl implements AuthRepositoryAbstract {
  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    // await Future.delayed(const Duration(milliseconds: 400));
    // return true;
  }

  @override
  Future<void> login({required String email, required String password}) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> registerUser(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}