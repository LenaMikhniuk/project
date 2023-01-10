import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:this_is_project/domain/repositories/auth/auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Auth _authImpl;

  AuthCubit(this._authImpl) : super(AuthState.initial());

  Future<void> logout() async {
    const storage = FlutterSecureStorage();

    try {
      emit(AuthState.loading());
      await _authImpl.logOut();
      storage.delete(key: 'user-token');
      await storage.containsKey(key: 'user-token');

      emit(AuthState.logout());
    } catch (_) {
      emit(AuthState.loading());
    }
  }
}
