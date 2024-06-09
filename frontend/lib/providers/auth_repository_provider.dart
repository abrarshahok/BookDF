import 'dart:io';
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
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

  // Fetch user data (example method)
  Future<void> fetchUserData() async {
    try {
      _setState(LoadingState());
      // Fetch data logic here
      // _setState(SuccessState(fetchedBooks));
    } catch (e) {
      _setState(ErrorState(e.toString()));
      rethrow;
    }
  }

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
      (error) => _setState(ErrorState('Failed to Login')),
      (success) {
        _setState(SuccessState(success));
        context.router.replace(const HomeRoute());
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
  }) async {
    try {
      _setState(LoadingState());

      final result = await AuthRepository.instance.signup(
          username: username, email: email, password: password, image: image);
      result.fold((error) {
        _setState(ErrorState('errorMessage'));
      }, (success) {
        _setState(SuccessState(null));
      });
    } catch (e) {
      _setState(ErrorState('Something went wrong'));
      rethrow;
    }
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

  // Delete user image method
  Future<void> _deleteUserImage(String userId) async {
    // Delete user image logic here
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

  // Sign out method
  void signOut() {
    // Sign out logic here
  }

  // Private method to set state and notify listeners
  void _setState(LoadState state, {bool build = true}) {
    _state = state;
    if (build) {
      notifyListeners();
    }
  }
}
