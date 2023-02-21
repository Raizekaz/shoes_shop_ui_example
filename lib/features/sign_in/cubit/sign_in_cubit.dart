import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
    this._authRepository,
  ) : super(const SignInState());

  final AuthenticationRepository _authRepository;

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

  Future<void> logInWithCredentials() async {
    if (state.status.isLoading) return;
    emit(state.copyWith(status: SignInStatus.loading));

    try {
      await _authRepository.logInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      emit(state.copyWith(status: SignInStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (error) {
      emit(
        state.copyWith(
          status: SignInStatus.error,
          errorMessage: error.message,
        ),
      );
    } on Object catch (error, stackTrace) {
      emit(state.copyWith(status: SignInStatus.error));
      addError(error, stackTrace);
      rethrow;
    }
  }

  Future<void> logInWithGoogle() async {
    if (state.status.isLoading) return;
    emit(state.copyWith(status: SignInStatus.loading));

    try {
      await _authRepository.logInWithGoogle();
      emit(state.copyWith(status: SignInStatus.success));
    } on LogInWithGoogleFailure catch (error) {
      emit(
        state.copyWith(
          status: SignInStatus.error,
          errorMessage: error.message,
        ),
      );
    } on Object catch (error, stackTrace) {
      emit(state.copyWith(status: SignInStatus.error));
      addError(error, stackTrace);
      rethrow;
    }
  }
}
