part of 'auth_cubit.dart';

enum AuthStatus {
  initial,
  unauthenticated,
  authenticated,
}

class AuthState extends Equatable {
  const AuthState._(this.status);

  factory AuthState.initial() {
    return const AuthState._(AuthStatus.initial);
  }
  factory AuthState.unauthenticated() {
    return const AuthState._(AuthStatus.unauthenticated);
  }
  factory AuthState.authenticated() {
    return const AuthState._(AuthStatus.authenticated);
  }

  final AuthStatus status;

  @override
  List<Object?> get props => [status];
}
