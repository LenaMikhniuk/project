import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:this_is_project/domain/models/auth_model/user.dart';
import 'package:this_is_project/domain/repositories/auth/auth_impl.dart';

part 'auth_page_state.dart';

class AuthPageCubit extends Cubit<AuthPageState> {
  final AuthImpl _authImpl;
  AuthPageCubit(this._authImpl) : super(const AuthPageInitial());

  Future<void> getUser(User user) async {
    emit(const AuthPageLoading());
    final user = await _authImpl.login();
    emit(AuthPageSuccess(user));
  }

  void onChanged(String value) {}
}
