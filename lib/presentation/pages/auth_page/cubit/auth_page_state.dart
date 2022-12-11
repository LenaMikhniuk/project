part of 'auth_page_cubit.dart';

abstract class AuthPageState {
  const AuthPageState();
}

class AuthPageInitial extends AuthPageState {
  const AuthPageInitial();
}

class AuthPageLoading extends AuthPageState {
  const AuthPageLoading();
}

class AuthPageSuccess extends AuthPageState {
  final User user;
  const AuthPageSuccess(this.user);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthPageSuccess && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class AuthPageError extends AuthPageState {
  final String message;
  const AuthPageError(this.message);
}
