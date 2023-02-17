import 'package:flutter/material.dart';
import 'package:shoes_shop_ui/main.dart';
import 'package:shoes_shop_ui/my_app.dart';
import 'package:shoes_shop_ui/routes/app_navigation.dart';

AppFactory makeAppFactory() => const _AppFactoryDefault();

class _AppFactoryDefault implements AppFactory {
  const _AppFactoryDefault();
  final _diContainer = const _DIContainer();

  @override
  Widget makeApp() => App(
        // authenticationRepository: _diContainer._makeAuthReposiroty(),
        screenFactory: _diContainer._makeScreenFactory(),
      );
}

class _DIContainer {
  const _DIContainer();

  // ignore: use_to_and_as_if_applicable
  ScreenFactory _makeScreenFactory() => ScreenFactoryDefault(this);
}

class ScreenFactoryDefault implements ScreenFactory {
  ScreenFactoryDefault(this._diContainer);
  final _DIContainer _diContainer;

  @override
  Widget makeLoginScreen() {
    return const Text('data');
  }

  @override
  Widget makeMainScreen() {
    // return MainScreen(screenFactory: _diContainer._makeScreenFactory());
    return const Text('data');
  }
}
