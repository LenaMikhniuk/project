import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:this_is_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:this_is_project/features/features.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit({
    required this.authRepository,
    required this.authCubit,
  }) : super(LoginPageState.initial());

  final AuthRepositoryAbstract authRepository;
  final AuthCubit authCubit;

  Future<void> login() async {
    try {
      emit(LoginPageState.loading());
      final token = await authRepository.login(
        name: state.name,
        password: state.password,
      );
      authCubit.authenticate(token);
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
}
