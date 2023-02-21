import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_shop_ui/features/main/view/main_screen.dart';
import 'package:shoes_shop_ui/features/onboarding/onboarding_screen.dart';
import 'package:shoes_shop_ui/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:shoes_shop_ui/features/sign_in/view/sign_in_screen.dart';
import 'package:shoes_shop_ui/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:shoes_shop_ui/features/sign_up/view/sign_up_screen.dart';
import 'package:shoes_shop_ui/main.dart';
import 'package:shoes_shop_ui/app/my_app.dart';
import 'package:shoes_shop_ui/routes/app_navigation.dart';

AppFactory makeAppFactory() => const _AppFactoryDefault();

class _AppFactoryDefault implements AppFactory {
  const _AppFactoryDefault();
  final _diContainer = const _DIContainer();

  @override
  Widget makeApp() => App(
        authRepository: _diContainer._makeAuthRepository(),
        screenFactory: _diContainer._makeScreenFactory(),
      );
}

class _DIContainer {
  const _DIContainer();

  ScreenFactory _makeScreenFactory() => ScreenFactoryDefault(this);
  AuthenticationRepository _makeAuthRepository() => AuthenticationRepository();
}

class ScreenFactoryDefault implements ScreenFactory {
  ScreenFactoryDefault(this._diContainer);
  final _DIContainer _diContainer;

  @override
  Widget makeSignInScreen() {
    return BlocProvider(
      create: (_) => SignInCubit(
        _diContainer._makeAuthRepository(),
      ),
      child: const SignInScreen(),
    );
  }

  @override
  Widget makeSignUpScreen() {
    return BlocProvider(
      create: (_) => SignUpCubit(
        _diContainer._makeAuthRepository(),
      ),
      child: const SignUpScreen(),
    );
  }

  @override
  Widget makeMainScreen() {
    return const MainScreen();
  }

  @override
  Widget makeOnboardingScreen() {
    return const OnBoardingScreen();
  }
}
