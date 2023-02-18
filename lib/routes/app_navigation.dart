import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationRouteNames {
  static const mainScreen = 'main_screen';
  static const signInScreen = 'sign_in';
  static const signUpScreen = 'sign_up';
  static const onboardingScreen = '/';
}

abstract class ScreenFactory {
  Widget makeMainScreen();
  Widget makeSignInScreen();
  Widget makeSignUpScreen();
  Widget makeOnboardingScreen();
}

class AppRouter {
  AppRouter(
    this.screenFactory,
  );
  final ScreenFactory screenFactory;

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
        path: '/sign_in',
        name: NavigationRouteNames.signInScreen,
        builder: (BuildContext context, GoRouterState state) {
          return screenFactory.makeSignInScreen();
        },
      ),
      GoRoute(
        path: '/sign_up',
        name: NavigationRouteNames.signUpScreen,
        builder: (BuildContext context, GoRouterState state) {
          return screenFactory.makeSignUpScreen();
        },
      ),
      GoRoute(
        path: '/main_screen',
        name: NavigationRouteNames.mainScreen,
        builder: (BuildContext context, GoRouterState state) {
          return screenFactory.makeMainScreen();
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
      GoRoute(
        path: '/',
        name: NavigationRouteNames.onboardingScreen,
        builder: (BuildContext context, GoRouterState state) {
          return screenFactory.makeOnboardingScreen();
        },
      ),
    ],
    // redirect: (BuildContext context, GoRouterState state) {
    // final loggedIn = appBloc.state.status == AppStatus.authenticated;
    // final loggingIn = state.subloc == '/login';

    // if (!loggedIn) return loggingIn ? null : '/login';
    // if (loggingIn) return '/';
    // return '/';
    // },
    // refreshListenable: GoRouterRefreshStream(appBloc.stream),
  );
}

// class GoRouterRefreshStream extends ChangeNotifier {
//   GoRouterRefreshStream(Stream<dynamic> stream) {
//     notifyListeners();
//     _subscription =
//         stream.asBroadcastStream().listen((dynamic _) => notifyListeners());
//   }

//   late final StreamSubscription<dynamic> _subscription;

//   @override
//   void dispose() {
//     _subscription.cancel();
//     super.dispose();
//   }
// }
