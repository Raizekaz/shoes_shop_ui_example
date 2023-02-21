import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_shop_ui/app/bloc/auth_bloc.dart';

abstract class NavigationRouteNames {
  static const mainScreen = 'main_screen';
  static const signInScreen = 'sign_in';
  static const signUpScreen = 'sign_up';
  static const onboardingScreen = 'onboard';
  static const onboardingDopScreen = 'onboard_dop';
}

abstract class NavigationRoutePath {
  static const mainScreen = '/';
  static const signInScreen = '/sign_in';
  static const signUpScreen = 'sign_in/sign_up';
  static const onboardingScreen = '/onboard';
  static const onboardingDopScreen = '/onboard_dop';
}

abstract class ScreenFactory {
  Widget makeMainScreen();
  Widget makeSignInScreen();
  Widget makeSignUpScreen();
  Widget makeOnboardingScreen();
  Widget makeOnboardingDopScreen();
}

class AppRouter {
  AppRouter({
    required this.screenFactory,
    required this.authBloc,
  });
  final ScreenFactory screenFactory;
  final AuthBloc authBloc;

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: NavigationRoutePath.onboardingScreen,
    routes: <GoRoute>[
      GoRoute(
        path: NavigationRoutePath.onboardingScreen,
        name: NavigationRouteNames.onboardingScreen,
        builder: (BuildContext context, GoRouterState state) {
          return screenFactory.makeOnboardingScreen();
        },
        redirect: (context, state) {
          if (authBloc.state.status.isAuth) {
            return NavigationRoutePath.mainScreen;
          } else {
            return null;
          }
        },
      ),
      GoRoute(
        path: NavigationRoutePath.signInScreen,
        name: NavigationRouteNames.signInScreen,
        builder: (BuildContext context, GoRouterState state) {
          return screenFactory.makeSignInScreen();
        },
        routes: [
          GoRoute(
            path: NavigationRoutePath.signUpScreen,
            name: NavigationRouteNames.signUpScreen,
            builder: (BuildContext context, GoRouterState state) {
              return screenFactory.makeSignUpScreen();
            },
            redirect: (context, state) {
              if (authBloc.state.status.isAuth) {
                return NavigationRoutePath.onboardingDopScreen;
              } else {
                return null;
              }
            },
          ),
        ],
      ),
      GoRoute(
        path: NavigationRoutePath.onboardingDopScreen,
        name: NavigationRouteNames.onboardingDopScreen,
        builder: (BuildContext context, GoRouterState state) {
          return screenFactory.makeOnboardingDopScreen();
        },
      ),
      GoRoute(
        path: NavigationRoutePath.mainScreen,
        name: NavigationRouteNames.mainScreen,
        builder: (BuildContext context, GoRouterState state) {
          return screenFactory.makeMainScreen();
        },
        redirect: (context, state) {
          if (authBloc.state.status.isUnauth) {
            return NavigationRoutePath.signInScreen;
          } else {
            return null;
          }
        },
        // routes: [
        //   GoRoute(
        //     path: 'heroes_screen',
        //     name: NavigationRouteNames.heroesScreen,
        //     builder: (BuildContext context, GoRouterState state) {
        //       return screenFactory.makeHeroesScreen();
        //     },

        //   ),
        // ],
      ),
    ],
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription =
        stream.asBroadcastStream().listen((dynamic _) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
