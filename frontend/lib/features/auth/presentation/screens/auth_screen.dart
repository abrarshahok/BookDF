import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:bookdf/components/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_sizes.dart';
import '/constants/app_colors.dart';
import '/constants/app_font_styles.dart';
import '/dependency_injection/dependency_injection.dart';
import '/states/load_state.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../../providers/auth_repository_provider.dart';
import '../../../../components/image_picker_widget.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Book',
                style: titleStyle,
              ),
              TextSpan(
                text: 'DF',
                style: titleAccentStyle,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: AuthCard(),
      ),
    );
  }
}

// ignore: must_be_immutable
class AuthCard extends StatelessWidget {
  AuthCard({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _usernameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthRepositoryProvider>(
      builder: (ctx, auth, _) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (auth.authMode == AuthMode.signup)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImagePickerWidget(
                        onImagePicked: (image) => auth.selectImage(image)),
                    gapH20,
                    Text(
                      'Username',
                      style:
                          secondaryStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                    gapH4,
                    CustomTextFormField(
                      key: ValueKey(
                        auth.authMode == AuthMode.signup
                            ? 'username-signup'
                            : 'username',
                      ),
                      hintText: 'Enter username here',
                      controller: _usernameController,
                      focusNode: _usernameFocusNode,
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Username is required!';
                        } else if (value.length < 3) {
                          return 'Username is too short!';
                        }
                        return null;
                      },
                    ),
                    gapH20,
                  ],
                )
              else
                const SizedBox(),
              Text(
                'Email',
                style: secondaryStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              gapH4,
              CustomTextFormField(
                key: ValueKey(
                  auth.authMode == AuthMode.signup ? 'email-signup' : 'email',
                ),
                inputType: TextInputType.emailAddress,
                hintText: 'Enter email here',
                controller: _emailController,
                focusNode: _emailFocusNode,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required!';
                  }
                  if (!value.contains('@')) {
                    return 'Invalid email!';
                  }
                  return null;
                },
              ),
              gapH20,
              Text(
                'Password',
                style: secondaryStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              gapH4,
              CustomTextFormField(
                key: ValueKey(auth.authMode == AuthMode.signup
                    ? 'password-signup'
                    : 'password'),
                obscureText: auth.hidePassword,
                suffixIcon: CustomIconButton(
                  onTap: auth.togglePasswordVisibility,
                  icon: auth.hidePassword ? IconlyLight.show : IconlyLight.hide,
                ),
                inputType: TextInputType.visiblePassword,
                hintText: 'Enter password here',
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                onSubmitted: (_) {
                  if (auth.authMode == AuthMode.signup) {
                    FocusScope.of(context)
                        .requestFocus(_confirmPasswordFocusNode);
                  } else {
                    _submit(context);
                  }
                },
                validator: (pass) {
                  if (pass!.isEmpty) {
                    return 'Password is required!';
                  }
                  if (pass.length < 5) {
                    return 'Password is too short!';
                  }
                  return null;
                },
              ),
              if (auth.authMode == AuthMode.signup)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gapH20,
                    Text(
                      'Confirm Password',
                      style:
                          secondaryStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                    gapH4,
                    CustomTextFormField(
                      key: const ValueKey('confirmPassword'),
                      obscureText: true,
                      focusNode: _confirmPasswordFocusNode,
                      onSubmitted: (_) {
                        _submit(context);
                      },
                      validator: (confirmPass) {
                        if (confirmPass != _passwordController.text) {
                          return 'Passwords do not match!';
                        }
                        return null;
                      },
                      hintText: 'Confirm password',
                    ),
                  ],
                ),
              gapH20,
              if (auth.state is LoadingState)
                const CircularProgressIndicator(
                  color: secondaryColor,
                )
              else
                Column(
                  children: [
                    CustomButton(
                      height: 50,
                      width: double.infinity,
                      textStyle: buttonStyle,
                      borderRadius: 8,
                      label:
                          auth.authMode == AuthMode.login ? 'LogIn' : 'SignUp',
                      onPressed: () => _submit(context),
                    ),
                    TextButton(
                      onPressed: () {
                        auth.switchAuthMode();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 4,
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        '${auth.authMode == AuthMode.login ? 'Sign Up' : 'Login'} Instead',
                        style: primaryButtonStyle,
                      ),
                    ),
                  ],
                )
            ],
          ),
        );
      },
    );
  }

  Future<void> _submit(BuildContext context) async {
    final auth = locator<AuthRepositoryProvider>();

    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (auth.authMode == AuthMode.signup && auth.pickedImage == null) {
      return;
    }

    _formKey.currentState!.save();

    try {
      if (auth.authMode == AuthMode.login) {
        await auth.signin(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          context: context,
        );
      } else {
        await auth.signUp(
          username: _usernameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          image: auth.pickedImage!,
          context: context,
        );
      }
    } catch (error) {
      log('Something went wrong', error: error);
    }
  }
}
