part of 'login_page_cubit.dart';

enum Status {
  inital,
  idle,
  loading,
  success,
  error,
}

class LoginPageState extends Equatable {
  const LoginPageState(
    this.status = State.initial, {
    this.name = '',
    this.password = '',
    this.error,
  });

  final Status status;
  final String name;
  final String password;
  final Object? error;

  @override
  List<Object?> get props => [
        status,
        name,
        password,
        error,
      ];

  LoginPageState copyWith({
    Status? status,
    String? name,
    String? password,
    Object? error,
  }) {
    return LoginPageState(
      status ?? this.status,
      name: name ?? this.name,
      password: password ?? this.password,
      error: error ?? this.error,
    );
  }
}
