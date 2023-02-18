import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_shop_ui/components/alert_dialog.dart';
import 'package:shoes_shop_ui/components/get_started_button_widget.dart';
import 'package:shoes_shop_ui/components/sign_in_textfield.dart';
import 'package:shoes_shop_ui/features/sign_in/cubit/sign_in_cubit.dart';
import 'package:shoes_shop_ui/resources/resources.dart';
import 'package:shoes_shop_ui/routes/app_navigation.dart';
import 'package:shoes_shop_ui/themes/app_colors.dart';
import 'package:shoes_shop_ui/themes/app_text_styles.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Text(
              'Sign In',
              style: AppTextStyles.fs36fw600,
            ),
            const SizedBox(height: 20),
            Text(
              'Please sign in to your Shoesly Account',
              style: AppTextStyles.fs16grey,
            ),
            const SizedBox(height: 100),
            _TextFormFieldWidget(
              emailController: _emailController,
              passwordController: _passwordController,
            ),
            const Spacer(flex: 3),
            BlocConsumer<SignInCubit, SignInState>(
              listener: (_, state) {
                if (state.status.isError) {
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialogWidget(
                          text: 'The Email or Password field is empty',
                        );
                      },
                    );
                  } else if (!isEmail(_emailController.text)) {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialogWidget(
                          text: 'Please write the correct email',
                        );
                      },
                    );
                  } else if (_passwordController.text.length <= 8) {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialogWidget(
                          text: 'Password must be at least 8 characters long',
                        );
                      },
                    );
                  }
                }
              },
              builder: (_, state) {
                return GetStartedButtonWidget(
                  title: state.status.isLoading
                      ? const CircularProgressIndicator(color: AppColors.white)
                      : Text(
                          'SIGN IN',
                          style: AppTextStyles.fs16fw600white,
                        ),
                  width: MediaQuery.of(context).size.width,
                  onTap: () {
                    context.read<SignInCubit>().logInWithCredentials();
                    FocusScope.of(context).unfocus();
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GetStartedButtonWidget(
                    icon: AppIcons.google,
                    title: Text(
                      'GOOGLE',
                      style: AppTextStyles.fs16fw600,
                    ),
                    width: MediaQuery.of(context).size.width * 0.375,
                    color: AppColors.white,
                    padding: 14,
                    border: Border.all(color: AppColors.grey300),
                    onTap: () {},
                  ),
                  GetStartedButtonWidget(
                    icon: AppIcons.facebook,
                    title: Text(
                      'FACEBOOK',
                      style: AppTextStyles.fs16fw600,
                    ),
                    width: MediaQuery.of(context).size.width * 0.375,
                    color: AppColors.white,
                    padding: 14,
                    border: Border.all(color: AppColors.grey300),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Join with us. ',
                  style: AppTextStyles.fs14grey,
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text(
                    'Create Account',
                    style: AppTextStyles.fs14fw600,
                  ),
                  onPressed: () {
                    context.pushNamed(NavigationRouteNames.signUpScreen);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _TextFormFieldWidget extends StatefulWidget {
  const _TextFormFieldWidget({
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  @override
  State<_TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<_TextFormFieldWidget> {
  bool _onEmail = false;
  bool _onPassword = false;
  bool _visible = true;

  BoxDecoration decoration(bool on) {
    return on == false
        ? BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.grey300),
            ),
          )
        : const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.black),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: AppTextStyles.fs16fw600,
        ),
        BlocBuilder<SignInCubit, SignInState>(
          builder: (_, state) {
            return TextFieldWidget(
              controller: widget.emailController,
              onChanged: (value) =>
                  context.read<SignInCubit>().emailChanged(value),
              onTap: () => setState(() {
                _onEmail = true;
                _onPassword = false;
              }),
              onSubmitted: (value) => setState(() => _onEmail),
              onTapOutside: (event) => setState(() => _onEmail),
              hint: 'example@mail.com',
              decoration: state.status.isError
                  ? const BoxDecoration(
                      border: Border(
                      bottom: BorderSide(color: CupertinoColors.systemRed),
                    ))
                  : decoration(_onEmail),
            );
          },
        ),
        const SizedBox(height: 20),
        Text(
          'Password',
          style: AppTextStyles.fs16fw600,
        ),
        BlocBuilder<SignInCubit, SignInState>(
          builder: (_, state) {
            return TextFieldWidget(
              onChanged: (value) =>
                  context.read<SignInCubit>().passwordChanged(value),
              controller: widget.passwordController,
              onTap: () => setState(() {
                _onEmail = false;
                _onPassword = true;
              }),
              obscure: _visible,
              onSubmitted: (value) => setState(() => _onPassword),
              onTapOutside: (event) => setState(() => _onPassword),
              hint: 'secret1234567',
              decoration: state.status.isError
                  ? const BoxDecoration(
                      border: Border(
                      bottom: BorderSide(color: CupertinoColors.systemRed),
                    ))
                  : decoration(_onPassword),
              suffix: GestureDetector(
                child: CupertinoButton(
                  child: _visible == false
                      ? const Icon(
                          Icons.visibility_outlined,
                          color: AppColors.grey,
                        )
                      : const Icon(
                          Icons.visibility_off_outlined,
                          color: AppColors.grey,
                        ),
                  onPressed: () => setState(() => _visible = !_visible),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
