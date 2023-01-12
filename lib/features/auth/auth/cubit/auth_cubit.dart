import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:this_is_project/features/auth/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryAbstract authRepoInstance;

  AuthCubit({required this.authRepoInstance}) : super(AuthState.initial()) {
    isAuthenticated();
  }

  Future<void> logout() async {
    const storage = FlutterSecureStorage();
    try {
      await authRepoInstance.logOut();
      storage.deleteAll();
      emit(AuthState.unauthenticated());
    } catch (_) {
      emit(AuthState.unauthenticated());
    }
  }

  Future<void> authenticate(String token) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'user_token', value: token);
    emit(AuthState.authenticated());
  }

  Future<void> isAuthenticated() async {
    await Future.delayed(const Duration(seconds: 2));
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'user_token');
    if (token != null) {
      emit(AuthState.authenticated());
    } else {
      emit(AuthState.unauthenticated());
    }
  }
}
