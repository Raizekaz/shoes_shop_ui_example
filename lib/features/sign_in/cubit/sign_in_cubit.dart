import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        email: state.email,
        status: SignInStatus.initial,
      ),
    );
  }

  void emailChanged(String value) {
    emit(
      state.copyWith(
        password: state.password,
        email: value,
        status: SignInStatus.initial,
      ),
    );
  }

  Future<void> _logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    Future.delayed(const Duration(seconds: 2), () {
      email = state.email;
      password = state.password;
    });
  }

  Future<void> logInWithCredentials() async {
    if (state.status.isLoading) return;
    emit(
      state.copyWith(status: SignInStatus.loading),
    );
    try {
      await _logInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      if (state.email == 'example@mail.com' &&
          state.password == 'secret1234567') {
        emit(
          state.copyWith(status: SignInStatus.success),
        );
      } else {
        emit(
          state.copyWith(status: SignInStatus.error),
        );
      }
    } on Object catch (error) {
      emit(
        state.copyWith(
          status: SignInStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
