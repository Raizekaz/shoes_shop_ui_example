part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class _AuthUserChanged extends AuthEvent {
  final User user;

  const _AuthUserChanged(this.user);

  @override
  List<Object> get props => [];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}
