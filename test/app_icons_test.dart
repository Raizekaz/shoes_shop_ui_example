import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shoes_shop_ui/resources/resources.dart';

void main() {
  test('app_icons assets test', () {
    expect(File(AppIcons.facebook).existsSync(), true);
    expect(File(AppIcons.google).existsSync(), true);
  });
}
