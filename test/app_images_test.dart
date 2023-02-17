import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shoes_shop_ui/resources/resources.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.onboardingOne).existsSync(), true);
    expect(File(AppImages.onboardingThree).existsSync(), true);
    expect(File(AppImages.onboardingTwo).existsSync(), true);
    expect(File(AppImages.splash).existsSync(), true);
  });
}
