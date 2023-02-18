import 'package:flutter/cupertino.dart';
import 'package:shoes_shop_ui/themes/app_colors.dart';

abstract class AppTextStyles {
  static const TextStyle fs14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    fontFamily: 'Noto Sans',
  );

  static final TextStyle fs48fw700 = fs14.copyWith(
    fontSize: 48,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle fs36fw600 = fs14.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle fs16grey = fs14.copyWith(
    fontSize: 16,
    color: AppColors.grey,
  );

  static final TextStyle fs14fw600 = fs14.copyWith(
    fontWeight: FontWeight.w600,
  );

  static final TextStyle fs16fw600white = fs14.copyWith(
    fontSize: 16,
    color: AppColors.white,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle fs16fw600 = fs14.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle fs14grey = fs14.copyWith(
    fontSize: 14,
    color: AppColors.grey,
  );
}
