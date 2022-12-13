import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenState.loading());

  Future<void> getToken() async {
    await Future.delayed(const Duration(seconds: 2));
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'user_token');
    if (token != null) {
      emit(SplashScreenState.navigateToHome());
    } else {
      emit(SplashScreenState.navigateToLogin());
    }
  }
}
