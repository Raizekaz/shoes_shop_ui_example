import 'package:flutter/material.dart';
import 'package:shoes_shop_ui/di_container/di_container.dart';

abstract class AppFactory {
  Widget makeApp();
}

final appFactory = makeAppFactory();

void main() {
  final app = appFactory.makeApp();
  runApp(app);
}
