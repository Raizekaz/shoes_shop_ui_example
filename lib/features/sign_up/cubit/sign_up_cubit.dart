import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(
    this._authRepository,
  ) : super(const SignUpState());

  final AuthenticationRepository _authRepository;

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        email: state.email,
        name: state.name,
        confirmPassword: state.confirmPassword,
        status: SignUpStatus.initial,
      ),
    );
  }

  void confirmPasswordChanged(String value) {
    emit(
      state.copyWith(
        password: state.password,
        email: state.email,
        name: state.name,
        confirmPassword: value,
        checkbox: state.checkbox,
        status: SignUpStatus.initial,
      ),
    );
  }

  void nameChanged(String value) {
    emit(
      state.copyWith(
        password: state.password,
        email: state.email,
        name: value,
        confirmPassword: state.confirmPassword,
        checkbox: state.checkbox,
        status: SignUpStatus.initial,
      ),
    );
  }

  void emailChanged(String value) {
    emit(
      state.copyWith(
        password: state.password,
        email: value,
        name: state.name,
        confirmPassword: state.confirmPassword,
        checkbox: state.checkbox,
        status: SignUpStatus.initial,
      ),
    );
  }

  void checkboxChanged() {
    emit(
      state.copyWith(
        password: state.password,
        email: state.email,
        name: state.name,
        confirmPassword: state.confirmPassword,
        checkbox: state.checkbox == CheckboxStatus.notActive
            ? CheckboxStatus.active
            : CheckboxStatus.notActive,
        status: SignUpStatus.initial,
      ),
    );
  }

  Future<void> signUpWithCredentials() async {
    if (state.status.isLoading) return;
    emit(state.copyWith(status: SignUpStatus.loading));

    if (state.checkbox.isNotActive) {
      emit(state.copyWith(status: SignUpStatus.error));
      return;
    } else if (state.checkbox.isActive &&
        state.password != state.confirmPassword) {
      emit(state.copyWith(status: SignUpStatus.error));
      return;
    }

    try {
      final result = await _authRepository.signUp(
        email: state.email,
        password: state.confirmPassword,
        name: state.name,
      );
      if (result != null) {
        emit(state.copyWith(status: SignUpStatus.success));
      }
    } on SignUpWithEmailAndPasswordFailure catch (error) {
      emit(
        state.copyWith(
          status: SignUpStatus.error,
          errorMessage: error.message,
        ),
      );
    } on Object catch (error, stackTrace) {
      emit(state.copyWith(status: SignUpStatus.error));
      addError(error, stackTrace);
      rethrow;
    }
  }
}
