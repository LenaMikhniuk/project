import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:this_is_project/domain/models/auth_model/user.dart';
import 'package:this_is_project/domain/repositories/auth/auth.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  final Auth _authImpl;
  LoginPageCubit(this._authImpl) : super(LoginPageState.initial());

  Future<void> login() async {
    try {
      await _authImpl.login(name: state.name, password: state.password);
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
