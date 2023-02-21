part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated }

extension AuthStatusX on AuthStatus {
  bool get isAuth => this == AuthStatus.authenticated;
  bool get isUnauth => this == AuthStatus.unauthenticated;
}

class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    this.user = User.empty,
  });

  final AuthStatus status;
  final User user;

  const AuthState.authenticated(User user)
      : this._(
          status: AuthStatus.authenticated,
          user: user,
        );

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
