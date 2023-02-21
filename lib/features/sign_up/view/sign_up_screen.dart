import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoes_shop_ui/components/alert_dialog.dart';
import 'package:shoes_shop_ui/components/get_started_button_widget.dart';
import 'package:shoes_shop_ui/components/sign_in_textfield.dart';
import 'package:shoes_shop_ui/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:shoes_shop_ui/resources/resources.dart';
import 'package:shoes_shop_ui/themes/app_colors.dart';
import 'package:shoes_shop_ui/themes/app_text_styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(email);
  }

  void _errorDialogs() {
    if (context.read<SignUpCubit>().state.status.isError) {
      if (_nameController.text.isEmpty) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return const AlertDialogWidget(
              text: 'Name field is empty',
            );
          },
        );
      } else if (_emailController.text.isEmpty) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return const AlertDialogWidget(
              text: 'Email field is empty',
            );
          },
        );
      } else if (_passwordController.text.isEmpty) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return const AlertDialogWidget(
              text: 'Password field is empty',
            );
          },
        );
      } else if (_confirmPasswordController.text.isEmpty) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return const AlertDialogWidget(
              text: 'Confirm Password field is empty',
            );
          },
        );
      } else if (!_isEmail(_emailController.text)) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return const AlertDialogWidget(
              text: 'Please write the correct email',
            );
          },
        );
      } else if (_passwordController.text.length < 8) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return const AlertDialogWidget(
              text: 'Password must be at least 8 characters long',
            );
          },
        );
      } else if (_passwordController.text != _confirmPasswordController.text) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return const AlertDialogWidget(
              text: 'The passwords don\'t match',
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 100),
                  Text(
                    'Create Account',
                    style: AppTextStyles.fs36fw600,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Please sign in to your Shoesly Account',
                    style: AppTextStyles.fs16fw600grey,
                  ),
                  const SizedBox(height: 60),
                  _TextFormFieldWidget(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    nameController: _nameController,
                    confirmPasswordController: _confirmPasswordController,
                  ),
                  const SizedBox(height: 60),
                  BlocConsumer<SignUpCubit, SignUpState>(
                    listener: (_, state) {
                      _errorDialogs();
                    },
                    builder: (_, state) {
                      return GetStartedButtonWidget(
                        title: state.status.isLoading
                            ? const CircularProgressIndicator(
                                color: AppColors.white)
                            : Text(
                                'CREATE ACCOUNT',
                                style: AppTextStyles.fs16fw700white,
                              ),
                        width: MediaQuery.of(context).size.width,
                        onTap: () {
                          context.read<SignUpCubit>().signUpWithCredentials();
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
                            style: AppTextStyles.fs16fw700,
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
                        'Have Account? ',
                        style: AppTextStyles.fs14grey,
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Text(
                          'Sign In Now',
                          style: AppTextStyles.fs14fw600,
                        ),
                        onPressed: () => context.pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
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
    required this.nameController,
    required this.confirmPasswordController,
  });

  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final TextEditingController? confirmPasswordController;
  final TextEditingController? nameController;

  @override
  State<_TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<_TextFormFieldWidget> {
  bool _onEmail = false;
  bool _onPassword = false;
  bool _onName = false;
  bool _onConfirmPassword = false;
  bool _visible = true;
  bool _isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(email);
  }

  void _name() {
    setState(() {
      _onName = true;
      _onEmail = false;
      _onPassword = false;
      _onConfirmPassword = false;
    });
  }

  void _email() {
    setState(() {
      _onName = false;
      _onEmail = true;
      _onPassword = false;
      _onConfirmPassword = false;
    });
  }

  void _password() {
    setState(() {
      _onName = false;
      _onEmail = false;
      _onPassword = true;
      _onConfirmPassword = false;
    });
  }

  void _confirmPassword() {
    setState(() {
      _onName = false;
      _onEmail = false;
      _onPassword = false;
      _onConfirmPassword = true;
    });
  }

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

  BoxDecoration _errorConfirmPassword() {
    final cubit = context.read<SignUpCubit>().state;
    return cubit.status.isError && cubit.confirmPassword.isEmpty ||
            cubit.status.isError && cubit.confirmPassword.length <= 8 ||
            cubit.status.isError && cubit.confirmPassword != cubit.password
        ? const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: CupertinoColors.systemRed),
            ),
          )
        : decoration(_onConfirmPassword);
  }

  BoxDecoration _errorPassword() {
    final cubit = context.read<SignUpCubit>().state;
    return cubit.status.isError && cubit.password.isEmpty ||
            cubit.status.isError && cubit.password.length <= 8 ||
            cubit.status.isError && cubit.confirmPassword != cubit.password
        ? const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: CupertinoColors.systemRed),
            ),
          )
        : decoration(_onPassword);
  }

  BoxDecoration _errorName() {
    final cubit = context.read<SignUpCubit>().state;
    return cubit.status.isError && cubit.name.isEmpty
        ? const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: CupertinoColors.systemRed),
            ),
          )
        : decoration(_onName);
  }

  BoxDecoration _errorEmail() {
    final cubit = context.read<SignUpCubit>().state;
    return cubit.status.isError && cubit.email.isEmpty ||
            cubit.status.isError && !_isEmail(cubit.email)
        ? const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: CupertinoColors.systemRed),
            ),
          )
        : decoration(_onEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: AppTextStyles.fs16fw700,
        ),
        BlocBuilder<SignUpCubit, SignUpState>(
          builder: (_, state) {
            return TextFieldWidget(
              keyboardType: TextInputType.name,
              controller: widget.nameController,
              onChanged: (value) =>
                  context.read<SignUpCubit>().nameChanged(value),
              onTap: _name,
              onSubmitted: (value) => setState(() => _onName = false),
              onTapOutside: (event) => setState(() {
                _onName = false;
                FocusScope.of(context).unfocus();
              }),
              hint: 'John Doe',
              decoration: _errorName(),
            );
          },
        ),
        const SizedBox(height: 20),
        Text(
          'Email',
          style: AppTextStyles.fs16fw700,
        ),
        BlocBuilder<SignUpCubit, SignUpState>(
          builder: (_, state) {
            return TextFieldWidget(
              keyboardType: TextInputType.emailAddress,
              controller: widget.emailController,
              onChanged: (value) =>
                  context.read<SignUpCubit>().emailChanged(value),
              onTap: _email,
              onSubmitted: (value) => setState(() => _onEmail = false),
              onTapOutside: (event) => setState(() {
                _onEmail = false;
                FocusScope.of(context).unfocus();
              }),
              hint: 'example@mail.com',
              decoration: _errorEmail(),
            );
          },
        ),
        const SizedBox(height: 20),
        Text(
          'Password',
          style: AppTextStyles.fs16fw700,
        ),
        BlocBuilder<SignUpCubit, SignUpState>(
          builder: (_, state) {
            return TextFieldWidget(
              keyboardType: TextInputType.text,
              onChanged: (value) =>
                  context.read<SignUpCubit>().passwordChanged(value),
              controller: widget.passwordController,
              onTap: _password,
              obscure: _visible,
              onSubmitted: (value) => setState(() => _onPassword = false),
              onTapOutside: (event) => setState(() {
                _onPassword = false;
                FocusScope.of(context).unfocus();
              }),
              hint: 'secret1234567',
              decoration: _errorPassword(),
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
        const SizedBox(height: 10),
        Text(
          'Your password must 8 or more characters',
          style: AppTextStyles.fs14grey,
        ),
        const SizedBox(height: 20),
        Text(
          'Confirm Password',
          style: AppTextStyles.fs16fw700,
        ),
        BlocBuilder<SignUpCubit, SignUpState>(
          builder: (_, state) {
            return TextFieldWidget(
              keyboardType: TextInputType.text,
              onChanged: (value) =>
                  context.read<SignUpCubit>().passwordChanged(value),
              controller: widget.confirmPasswordController,
              onTap: _confirmPassword,
              obscure: _visible,
              onSubmitted: (value) =>
                  setState(() => _onConfirmPassword = false),
              onTapOutside: (event) => setState(() {
                _onConfirmPassword = false;
                FocusScope.of(context).unfocus();
              }),
              hint: 'secret1234567',
              decoration: _errorConfirmPassword(),
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
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => context.read<SignUpCubit>().checkboxChanged(),
              child: BlocBuilder<SignUpCubit, SignUpState>(
                builder: (_, state) {
                  return state.checkbox.isNotActive
                      ? Image.asset(AppIcons.checkboxNotActive)
                      : Image.asset(AppIcons.checkboxActive);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'By Signing up, you agree to the ',
                      style: AppTextStyles.fs14grey,
                    ),
                    const TextSpan(
                      text: 'Terms of Service ',
                      style: AppTextStyles.fs14,
                    ),
                    TextSpan(
                      text: 'and ',
                      style: AppTextStyles.fs14grey,
                    ),
                    const TextSpan(
                      text: 'Privacy Policy',
                      style: AppTextStyles.fs14,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
