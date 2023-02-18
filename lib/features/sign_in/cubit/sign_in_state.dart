// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_in_cubit.dart';

enum SignInStatus { initial, loading, success, error }

extension SignInStatusX on SignInStatus {
  bool get isInitial => this == SignInStatus.initial;
  bool get isSuccess => this == SignInStatus.success;
  bool get isLoading => this == SignInStatus.loading;
  bool get isError => this == SignInStatus.error;
}

class SignInState extends Equatable {
  const SignInState({
    this.status = SignInStatus.initial,
    this.errorMessage,
    this.email = '',
    this.password = '',
  });

  final SignInStatus status;
  final String email;
  final String password;
  final String? errorMessage;

  @override
  List<Object> get props => [
        status,
        password,
        email,
      ];

  SignInState copyWith({
    SignInStatus? status,
    bool? valid,
    String? email,
    String? password,
    String? errorMessage,
  }) {
    return SignInState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
