part of 'login_page_cubit.dart';

enum Status {
  inital,
  loading,
  success,
  error,
  logout,
}

class LoginPageState extends Equatable {
  const LoginPageState._(
    this.status, {
    this.name = '',
    this.password = '',
  });

  factory LoginPageState.initial() {
    return const LoginPageState._(Status.inital);
  }
  factory LoginPageState.loading() {
    return const LoginPageState._(Status.loading);
  }
  factory LoginPageState.success() {
    return const LoginPageState._(Status.success);
  }

  factory LoginPageState.error() {
    return const LoginPageState._(Status.error);
  }
  factory LoginPageState.logout() {
    return const LoginPageState._(Status.logout);
  }

  final Status status;
  final String name;
  final String password;

  @override
  List<Object?> get props => [
        status,
        name,
        password,
      ];

  LoginPageState copyWith({
    Status? status,
    String? name,
    String? password,
  }) {
    return LoginPageState._(
      status ?? this.status,
      name: name ?? this.name,
      password: password ?? this.password,
    );
  }
}
