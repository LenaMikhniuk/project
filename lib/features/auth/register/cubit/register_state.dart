part of 'register_cubit.dart';

enum RegisterStateStatus {
  inital,
  idle,
  loading,
  success,
  error,
  validationError,
}

class RegisterState extends Equatable {
  const RegisterState(
    this.status, {
    this.name = '',
    this.password = '',
    this.hidePassword = true,
  });

  final RegisterStateStatus status;
  final String name;
  final String password;
  final bool hidePassword;

  @override
  List<Object?> get props => [
        status,
        name,
        password,
        hidePassword,
      ];

  RegisterState copyWith({
    RegisterStateStatus? status,
    String? name,
    String? password,
    bool? hidePassword,
  }) {
    return RegisterState(
      status ?? this.status,
      name: name ?? this.name,
      password: password ?? this.password,
      hidePassword: hidePassword ?? this.hidePassword,
    );
  }
}
