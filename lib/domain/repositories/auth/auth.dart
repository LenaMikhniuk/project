abstract class Auth {
  Future<String> login({required String name, required String password});
  Future<bool> logOut();
}

class MockAuthImpl implements Auth {
  @override
  Future<bool> logOut() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }

  @override
  Future<String> login({required String name, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return 'token_abc_1234';
  }
}
