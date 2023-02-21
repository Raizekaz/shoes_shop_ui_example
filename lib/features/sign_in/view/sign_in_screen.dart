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
  @override
  void dispose() {
    _emailController
      ..clear()
      ..dispose();
    _passwordController
      ..clear()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      child: BlocListener<SignInCubit, SignInState>(
        listener: (_, state) {
          if (state.status.isError && state.errorMessage != null) {
            showCupertinoDialog(
              context: context,
              builder: (_) {
                return AlertDialogWidget(
                  text: state.errorMessage!,
                );
              },
            );
          } else if (state.status.isError &&
              _emailController.text.isEmpty &&
              state.errorMessage == null) {
            showCupertinoDialog(
              context: context,
              builder: (_) {
                return const AlertDialogWidget(
                  text: 'The Email field is empty',
                );
              },
            );
          } else if (state.status.isError &&
              _passwordController.text.isEmpty &&
              state.errorMessage == null) {
            showCupertinoDialog(
              context: context,
              builder: (_) {
                return const AlertDialogWidget(
                  text: 'The Password field is empty',
                );
              },
            );
          }
        },
        child: _ContentWidget(
          emailController: _emailController,
          passwordController: _passwordController,
        ),
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
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
            style: AppTextStyles.fs16fw500grey,
          ),
          const SizedBox(height: 100),
          _TextFormFieldWidget(
            emailController: _emailController,
            passwordController: _passwordController,
          ),
          const Spacer(flex: 3),
          BlocBuilder<SignInCubit, SignInState>(
            builder: (_, state) {
              return GetStartedButtonWidget(
                title: state.status.isLoading
                    ? const CircularProgressIndicator(
                        strokeWidth: 2, color: AppColors.white)
                    : Text(
                        'SIGN IN',
                        style: AppTextStyles.fs16fw700white,
                      ),
                width: MediaQuery.of(context).size.width,
                onTap: () {
                  state.status.isLoading
                      ? null
                      : context.read<SignInCubit>().logInWithCredentials();
                  FocusScope.of(context).unfocus();

                  context.goNamed(NavigationRouteNames.mainScreen);
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
                    style: AppTextStyles.fs16fw700,
                  ),
                  width: MediaQuery.of(context).size.width * 0.375,
                  color: AppColors.white,
                  padding: 14,
                  border: Border.all(color: AppColors.grey300),
                  onTap: () => context.read<SignInCubit>().logInWithGoogle(),
                ),
                GetStartedButtonWidget(
                  icon: AppIcons.facebook,
                  title: Text(
                    'FACEBOOK',
                    style: AppTextStyles.fs16fw700,
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
          style: AppTextStyles.fs16fw700,
        ),
        BlocBuilder<SignInCubit, SignInState>(
          builder: (_, state) {
            return TextFieldWidget(
              keyboardType: TextInputType.emailAddress,
              controller: widget.emailController,
              onChanged: (value) =>
                  context.read<SignInCubit>().emailChanged(value),
              onTap: () => setState(() {
                _onEmail = true;
                _onPassword = false;
              }),
              onSubmitted: (value) => setState(() => _onEmail = false),
              onTapOutside: (event) => setState(() {
                _onEmail = false;
                FocusScope.of(context).unfocus();
              }),
              hint: 'example@mail.com',
              decoration: (state.status.isError &&
                          state.errorMessage != null) ||
                      (state.email.isEmpty && state.status.isError)
                  ? const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: CupertinoColors.systemRed),
                      ),
                    )
                  : decoration(_onEmail),
            );
          },
        ),
        const SizedBox(height: 20),
        Text(
          'Password',
          style: AppTextStyles.fs16fw700,
        ),
        BlocBuilder<SignInCubit, SignInState>(
          builder: (_, state) {
            return TextFieldWidget(
              keyboardType: TextInputType.text,
              onChanged: (value) =>
                  context.read<SignInCubit>().passwordChanged(value),
              controller: widget.passwordController,
              onTap: () => setState(() {
                _onEmail = false;
                _onPassword = true;
              }),
              obscure: _visible,
              onSubmitted: (value) => setState(() => _onPassword = false),
              onTapOutside: (event) => setState(() {
                _onPassword = false;
                FocusScope.of(context).unfocus();
              }),
              hint: 'secret1234567',
              decoration: (state.status.isError &&
                          state.errorMessage != null) ||
                      (state.password.isEmpty && state.status.isError)
                  ? const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: CupertinoColors.systemRed),
                      ),
                    )
                  : decoration(_onPassword),
              suffix: GestureDetector(
                child: CupertinoButton(
                  child: _visible == false
                      ? const Icon(
                          Icons.visibility_outlined,
                          color: AppColors.black,
                        )
                      : const Icon(
                          Icons.visibility_off_outlined,
                          color: AppColors.black,
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
