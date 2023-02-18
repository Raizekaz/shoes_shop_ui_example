import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        email: state.email,
        status: SignUpStatus.initial,
      ),
    );
  }

  void emailChanged(String value) {
    emit(
      state.copyWith(
        password: state.password,
        email: value,
        status: SignUpStatus.initial,
      ),
    );
  }

  Future<void> _signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    Future.delayed(const Duration(seconds: 2), () {
      email = state.email;
      password = state.password;
    });
  }

  Future<void> signUpWithCredentials() async {
    if (state.status.isLoading) return;
    emit(
      state.copyWith(status: SignUpStatus.loading),
    );
    try {
      await _signUpWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      if (state.email == 'example@mail.com' &&
          state.password == 'secret1234567') {
        emit(
          state.copyWith(status: SignUpStatus.success),
        );
      } else {
        emit(
          state.copyWith(status: SignUpStatus.error),
        );
      }
    } on Object catch (error) {
      emit(
        state.copyWith(
          status: SignUpStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
