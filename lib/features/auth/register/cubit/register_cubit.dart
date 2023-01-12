import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:this_is_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:this_is_project/features/features.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required this.repository,
    required this.authcubit,
  }) : super(RegisterState.initial());

  final AuthRepositoryAbstract repository;
  final AuthCubit authcubit;

  Future<void> registerUser() async {
    try {
      emit(RegisterState.loading());
      final user = await repository.registerUser(
        state.name,
        state.password,
      );
      authcubit.authenticate(user.id);
      emit(RegisterState.success());
    } catch (e) {
      emit(RegisterState.error());
    }
  }

  void togglePasswordVisibility(bool hidePassword) {
    hidePassword = !hidePassword;
    emit(state.copyWith(hidePassword: hidePassword));
  }

  void onNameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  void onPasswordChanged(String value) {
    emit(state.copyWith(password: value));
  }
}
