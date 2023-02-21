import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shoes_shop_ui/bootstrap.dart';
import 'package:shoes_shop_ui/di_container/di_container.dart';
import 'package:shoes_shop_ui/firebase_options.dart';

abstract class AppFactory {
  Widget makeApp();
}

final appFactory = makeAppFactory();

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authRepository = AuthenticationRepository();
  await authRepository.user.first;
  final app = appFactory.makeApp();
  await bootstrap(() {
    return app;
  });
  FlutterNativeSplash.remove();
}
