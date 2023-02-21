// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';

// enum AuthRoute { login, main }

// class AuthScope extends StatefulWidget {
//   const AuthScope({
//     super.key,
//     required this.child,
//   });

//   final Widget child;

//   static void signIn() => FirebaseAuth.instance.authStateChanges();
//   static void logOut() => FirebaseAuth.instance.authStateChanges.;
//   static void setRoute(BuildContext context, AuthRoute route) => context
//       .findAncestorStateOfType<_AuthScopeState>()
//       ?._authController
//       .value = route;

//   @override
//   State<AuthScope> createState() => _AuthScopeState();
// }

// class _AuthScopeState extends State<AuthScope> {
//   final ValueNotifier<AuthRoute> _authController =
//       ValueNotifier(AuthRoute.login);

//   @override
//   void dispose() {
//     _authController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: _authController,
//       builder: (context, route, _) {
//         Widget authRouter() {
//           if (AuthController.instance.state.isAuth) return widget.child;
//         }
//       },
//     );
//   }
// }
