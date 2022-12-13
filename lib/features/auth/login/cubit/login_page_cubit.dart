import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:this_is_project/domain/repositories/auth/auth.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  final Auth _authImpl;

  LoginPageCubit(this._authImpl) : super(LoginPageState.initial());

  Future<void> login() async {
    const storage = FlutterSecureStorage();

    try {
      final token = await _authImpl.login(name: state.name, password: state.password);
      storage.write(key: 'user_token', value: token);
      final c = await storage.containsKey(key: 'user_token');
      print(c);
      emit(LoginPageState.success());
    } catch (_) {
      emit(LoginPageState.error());
    }
  }

  void onNameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  void onPasswordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  Future<void> logout() async {
    const storage = FlutterSecureStorage();
    try {
      await _authImpl.logOut();
      storage.delete(key: 'user_token');
    } catch (_) {
      emit(LoginPageState.error());
    }
  }
}
