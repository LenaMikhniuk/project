part of 'auth_cubit.dart';

enum AuthStatus {
  initial,
  loading,
  error,
  logout,
}

class AuthState extends Equatable {
  const AuthState._(this.status);

  factory AuthState.initial() {
    return const AuthState._(AuthStatus.initial);
  }
  factory AuthState.loading() {
    return const AuthState._(AuthStatus.loading);
  }
  factory AuthState.logout() {
    return const AuthState._(AuthStatus.logout);
  }
  factory AuthState.error() {
    return const AuthState._(AuthStatus.error);
  }

  final AuthStatus status;

  @override
  List<Object?> get props => [status];

  AuthState copyWith({
    AuthStatus? status,
  }) {
    return AuthState._(status ?? this.status);
  }
}
