import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:bookdf/constants/app_colors.dart';
import 'package:bookdf/constants/app_font_styles.dart';
import 'package:bookdf/dependency_injection/dependency_injection.dart';
import 'package:bookdf/states/load_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../../providers/auth_repository_provider.dart';
import '../widgets/image_picker_widget.dart';

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

  final _passwordController = TextEditingController();

  final Map<String, String> _authData = {
    'username': '',
    'email': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthRepositoryProvider>(
      builder: (ctx, auth, _) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (auth.authMode == AuthMode.signup)
                Column(
                  children: [
                    ImagePickerWidget(auth.selectImage),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      key: ValueKey(
                        auth.authMode == AuthMode.signup
                            ? 'username-signup'
                            : 'username',
                      ),
                      hintText: 'Username',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Username is required!';
                        } else if (value.length < 3) {
                          return 'Username is too short!';
                        }
                        return null;
                      },
                      onSaved: (username) {
                        _authData['username'] = username!;
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                )
              else
                const SizedBox(),
              CustomTextFormField(
                key: ValueKey(
                  auth.authMode == AuthMode.signup ? 'email-signup' : 'email',
                ),
                hintText: 'Email',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required!';
                  }
                  if (!value.contains('@')) {
                    return 'Invalid email!';
                  }
                  return null;
                },
                onSaved: (email) {
                  _authData['email'] = email!;
                },
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                key: ValueKey(auth.authMode == AuthMode.signup
                    ? 'password-signup'
                    : 'password'),
                obscureText: true,
                hintText: 'Password',
                controller: _passwordController,
                validator: (pass) {
                  if (pass!.isEmpty) {
                    return 'Password is required!';
                  }
                  if (pass.length < 5) {
                    return 'Password is too short!';
                  }
                  return null;
                },
                onSaved: (password) {
                  _authData['password'] = password!;
                },
              ),
              if (auth.authMode == AuthMode.signup)
                Column(
                  children: [
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      key: const ValueKey('confirmPassword'),
                      obscureText: true,
                      validator: (confirmPass) {
                        if (confirmPass != _passwordController.text) {
                          return 'Passwords do not match!';
                        }
                        return null;
                      },
                      hintText: 'Confirm Password',
                    ),
                  ],
                ),
              // else
              //   const SizedBox(),
              const SizedBox(height: 10),
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
                      label:
                          auth.authMode == AuthMode.login ? 'LogIn' : 'SignUp',
                      onPressed: () => _submit(context),
                    ),
                    TextButton(
                      onPressed: () {
                        auth.switchAuthMode();
                        _passwordController.clear();
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
          email: _authData['email']!,
          password: _authData['password']!,
          context: context,
        );
      } else {
        await auth.signUp(
          username: _authData['username']!,
          email: _authData['email']!,
          password: _authData['password']!,
          image: auth.pickedImage!,
        );
      }
    } catch (error) {
      log('Something went wrong', error: error);
    }
  }
}
