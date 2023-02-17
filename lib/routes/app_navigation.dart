import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationRouteNames {
  static const mainScreen = '/';
  static const loginScreen = 'login';
}

abstract class ScreenFactory {
  Widget makeMainScreen();
  Widget makeLoginScreen();
}

class AppRouter {
  AppRouter(
    this.screenFactory,
  );
  final ScreenFactory screenFactory;

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        path: '/login',
        name: NavigationRouteNames.loginScreen,
        builder: (BuildContext context, GoRouterState state) {
          return screenFactory.makeLoginScreen();
        },
      ),
      GoRoute(
        path: '/',
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
    ],
    // redirect: (BuildContext context, GoRouterState state) {
    //   final loggedIn = appBloc.state.status == AppStatus.authenticated;
    //   final loggingIn = state.subloc == '/login';

    //   if (!loggedIn) return loggingIn ? null : '/login';
    //   if (loggingIn) return '/';
    //   return null;
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
