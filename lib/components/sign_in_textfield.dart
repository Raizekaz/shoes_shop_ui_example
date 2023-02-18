import 'package:flutter/cupertino.dart';
import 'package:shoes_shop_ui/themes/app_text_styles.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.onTap,
    required this.decoration,
    required this.onSubmitted,
    required this.onTapOutside,
    required this.hint,
    this.obscure = false,
    this.suffix,
    this.onChanged,
  });

  final TextEditingController? controller;
  final void Function()? onTap;
  final BoxDecoration decoration;
  final void Function(String)? onSubmitted;
  final void Function(PointerDownEvent)? onTapOutside;
  final bool obscure;
  final String hint;
  final Widget? suffix;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      onChanged: onChanged,
      obscureText: obscure,
      placeholder: hint,
      placeholderStyle: AppTextStyles.fs14grey,
      padding: const EdgeInsets.symmetric(vertical: 20),
      controller: controller,
      onTap: onTap,
      onSubmitted: onSubmitted,
      onTapOutside: onTapOutside,
      decoration: decoration,
      suffix: suffix,
    );
  }
}
