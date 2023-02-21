import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
    emit(
      state.copyWith(status: SignUpStatus.loading),
    );
    try {
      await _authRepository.signUp(
        email: state.email,
        password: state.password,
      );

      emit(
        state.copyWith(status: SignUpStatus.success),
      );
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
