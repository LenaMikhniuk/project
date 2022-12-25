part of 'register_cubit.dart';

enum RegisterStateStatus {
  inital,
  loading,
  loaded,
  success,
  error,
  validationError,
}

class RegisterState extends Equatable {
  const RegisterState._(
    this.status, {
    this.name = '',
    this.password = '',
    this.hidePassword = true,
  });

  factory RegisterState.initial() {
    return const RegisterState._(RegisterStateStatus.inital);
  }
  factory RegisterState.loading() {
    return const RegisterState._(RegisterStateStatus.loading);
  }
  factory RegisterState.success() {
    return const RegisterState._(RegisterStateStatus.success);
  }
  factory RegisterState.loaded() {
    return const RegisterState._(RegisterStateStatus.success);
  }

  factory RegisterState.error() {
    return const RegisterState._(RegisterStateStatus.error);
  }
  factory RegisterState.validationError() {
    return const RegisterState._(RegisterStateStatus.validationError);
  }

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
    return RegisterState._(
      status ?? this.status,
      name: name ?? this.name,
      password: password ?? this.password,
      hidePassword: hidePassword ?? this.hidePassword,
    );
  }
}
