import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:this_is_project/domain/repositories/register/register.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final Register _register;

  RegisterCubit(this._register) : super(RegisterState.initial());

  Future<void> registerUser() async {
    try {
      await _register.registerUser(state.name, state.password);
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
