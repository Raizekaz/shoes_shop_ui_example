import 'package:flutter/cupertino.dart';
import 'package:shoes_shop_ui/themes/app_colors.dart';

abstract class AppTextStyles {
  static const TextStyle fs14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    fontFamily: 'Urbanist',
  );

  static final TextStyle fs48fw700 = fs14.copyWith(
    fontSize: 48,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle fs36fw600 = fs14.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle fs16fw600grey = fs14.copyWith(
    fontSize: 16,
    color: AppColors.grey,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle fs16fw500grey = fs14.copyWith(
    fontSize: 16,
    color: AppColors.grey,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle fs14fw600 = fs14.copyWith(
    fontWeight: FontWeight.w600,
  );

  static final TextStyle fs16fw700white = fs14.copyWith(
    fontSize: 16,
    color: AppColors.white,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle fs16fw700 = fs14.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle fs14fw600grey = fs14.copyWith(
    fontSize: 14,
    color: AppColors.grey,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle fs14grey = fs14.copyWith(
    fontSize: 14,
    color: AppColors.grey,
  );
}
