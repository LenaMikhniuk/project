import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:this_is_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:this_is_project/features/features.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit({
    required this.authRepository,
    required this.authCubit,
  }) : super(const LoginPageState(Status.inital));

  final AuthRepositoryAbstract authRepository;
  final AuthCubit authCubit;

  Future<void> login() async {
    try {
      emit(state.copyWith(status: Status.loading));
      await authRepository.login(
        email: state.name,
        password: state.password,
      );

      await authCubit.authenticate();
      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.error, error: e));
      emit(state.copyWith(status: Status.idle));
    }
  }

  void onNameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  void onPasswordChanged(String value) {
    emit(state.copyWith(password: value));
  }
}
