// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_cubit.dart';

enum SignUpStatus { initial, loading, success, error }

extension SignUpStatusX on SignUpStatus {
  bool get isInitial => this == SignUpStatus.initial;
  bool get isSuccess => this == SignUpStatus.success;
  bool get isLoading => this == SignUpStatus.loading;
  bool get isError => this == SignUpStatus.error;
}

enum CheckboxStatus { active, notActive }

extension CheckboxStatusX on CheckboxStatus {
  bool get isActive => this == CheckboxStatus.active;
  bool get isNotActive => this == CheckboxStatus.notActive;
}

class SignUpState extends Equatable {
  const SignUpState({
    this.status = SignUpStatus.initial,
    this.errorMessage,
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.checkbox = CheckboxStatus.notActive,
  });

  final String name;
  final SignUpStatus status;
  final String email;
  final String password;
  final String confirmPassword;
  final CheckboxStatus checkbox;
  final String? errorMessage;

  @override
  List<Object> get props => [
        status,
        password,
        email,
        name,
        confirmPassword,
        checkbox,
      ];

  SignUpState copyWith({
    String? name,
    SignUpStatus? status,
    String? email,
    String? password,
    String? confirmPassword,
    CheckboxStatus? checkbox,
    String? errorMessage,
  }) {
    return SignUpState(
      name: name ?? this.name,
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      checkbox: checkbox ?? this.checkbox,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
