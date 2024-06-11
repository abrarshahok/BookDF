import 'dart:io';
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:bookdf/utils/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '/features/auth/data/respository/auth_respository.dart';
import '/routes/app_router.gr.dart';
import '/states/load_state.dart';

// Enum for Auth Mode
enum AuthMode { signup, login }

@lazySingleton
class AuthRepositoryProvider extends ChangeNotifier {
  AuthMode authMode = AuthMode.login;
  File? pickedImage;

  LoadState _state = InitialState();

  LoadState get state => _state;

  // Login method
  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _setState(LoadingState());

    final result = await AuthRepository.instance.signin(
      email: email,
      password: password,
    );

    result.fold(
      (error) => _setState(ErrorState(error.message)),
      (success) {
        if (success) {
          _setState(SuccessState(success));
        } else {
          showToast('Singin Failed', context);
        }
      },
    );
  }

  // Select image method
  void selectImage(File image) {
    pickedImage = image;
    log(pickedImage!.path);
    notifyListeners();
  }

  // Sign up method
  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required File image,
    required BuildContext context,
  }) async {
    _setState(LoadingState());

    final result = await AuthRepository.instance.signup(
      username: username,
      email: email,
      password: password,
      image: image,
    );
    result.fold(
      (error) {
        _setState(ErrorState(error.message));
      },
      (success) {
        if (success) {
          showToast('Signup Success', context);
        } else {
          showToast('Signup Failed!', context, isError: true);
        }
        switchAuthMode();
      },
    );
  }

  // Update profile method
  Future<void> updateProfile(String name) async {
    try {
      _setState(LoadingState());

      // Update profile logic here

      _setState(InitialState());
    } catch (e) {
      _setState(ErrorState('Something went wrong'));
      rethrow;
    }
  }

  // Switch auth mode method
  void switchAuthMode() {
    if (authMode == AuthMode.login) {
      authMode = AuthMode.signup;
    } else {
      authMode = AuthMode.login;
    }
    notifyListeners();
  }

  void autologin() async {
    _setState(LoadingState(), build: false);

    final result = await AuthRepository.instance.autoLogin();

    result.fold(
      (error) => _setState(ErrorState(error.message)),
      (success) => _setState(SuccessState(success)),
    );
  }

  void addReadingSession(String bookId) {
    AuthRepository.instance.addReadingSession(bookId);
    _setState(SuccessState(true));
  }

  void deleteReadingSession(String bookId) {
    AuthRepository.instance.deleteReadingSession(bookId);
    _setState(SuccessState(true));
  }

  // Sign out method
  void signOut(BuildContext context) {
    AuthRepository.instance.signOut();
    context.router.replace(const AuthRoute());
  }

  // Private method to set state and notify listeners
  void _setState(LoadState state, {bool build = true}) {
    _state = state;
    if (build) {
      notifyListeners();
    }
  }
}
