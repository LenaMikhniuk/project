part of 'splash_screen_cubit.dart';

enum SplashScreenStateStatus {
  loading,
  navigateToHome,
  navigateToLogin,
}

class SplashScreenState extends Equatable {
  const SplashScreenState._(this.status);

  factory SplashScreenState.loading() {
    return const SplashScreenState._(SplashScreenStateStatus.loading);
  }
  factory SplashScreenState.navigateToLogin() {
    return const SplashScreenState._(SplashScreenStateStatus.navigateToLogin);
  }

  factory SplashScreenState.navigateToHome() {
    return const SplashScreenState._(SplashScreenStateStatus.navigateToHome);
  }

  final SplashScreenStateStatus status;

  @override
  List<Object> get props => [status];
}
