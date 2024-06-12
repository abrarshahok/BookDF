import 'dart:io';
import 'package:bookdf/utils/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../features/book/data/respository/book_repository.dart';
import '/features/auth/data/respository/auth_respository.dart';
import '/states/load_state.dart';

enum AuthMode { signup, login }

@lazySingleton
class AuthRepositoryProvider extends ChangeNotifier {
  AuthMode authMode = AuthMode.login;
  File? pickedImage;

  LoadState _authState = InitialState();
  LoadState get authState => _authState;

  bool _isUpdatingProfile = false;
  bool get isUpdatingProfile => _isUpdatingProfile;

  bool _hidePassword = true;
  bool get hidePassword => _hidePassword;

  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _setAuthState(LoadingState());

    final result = await AuthRepository.instance.signin(
      email: email,
      password: password,
    );

    result.fold(
      (error) => _setAuthState(ErrorState(error.message)),
      (success) {
        if (success) {
          _setAuthState(SuccessState(success));
        } else {
          showToast('Singin Failed', context);
        }
      },
    );
  }

  void selectImage(File image) {
    pickedImage = image;
    notifyListeners();
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required File image,
    required BuildContext context,
  }) async {
    _setAuthState(LoadingState());

    final result = await AuthRepository.instance.signup(
      username: username,
      email: email,
      password: password,
      image: image,
    );
    result.fold(
      (error) {
        _setAuthState(ErrorState(error.message));
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

  void updateProfile(String username, File? image, BuildContext context) async {
    _isUpdatingProfile = true;
    notifyListeners();

    final result = await AuthRepository.instance.updateUser(username, image);

    result.fold(
      (error) {
        showToast('Something went wrong!', context, isError: true);
      },
      (success) {
        Navigator.pop(context);
        showToast(success, context);
      },
    );

    _isUpdatingProfile = false;
    notifyListeners();
  }

  void autologin() async {
    _setAuthState(LoadingState(), build: false);

    final result = await AuthRepository.instance.autoLogin();

    result.fold(
      (error) => _setAuthState(ErrorState(error.message)),
      (success) => _setAuthState(SuccessState(success)),
    );
  }

  void addReadingSession(String bookId) {
    AuthRepository.instance.addReadingSession(bookId);
    _setAuthState(SuccessState(true));
  }

  void deleteReadingSession(String bookId) {
    AuthRepository.instance.deleteReadingSession(bookId);
    _setAuthState(SuccessState(true));
  }

  void toggleBookmarks(String bookId, BuildContext context) async {
    final result = await BookRepository.instance.toggleBookmarks(bookId);

    result.fold(
      (error) {
        showToast('Something went wrong!', context, isError: true);
      },
      (message) {
        AuthRepository.instance.toggleBookmarks(bookId);
        showToast(message, context);
      },
    );
    notifyListeners();
  }

  void signOut(BuildContext context) {
    AuthRepository.instance.signOut();
    Navigator.pop(context);
    Navigator.pop(context);
    _setAuthState(SuccessState(false));
  }

  void switchAuthMode() {
    if (authMode == AuthMode.login) {
      authMode = AuthMode.signup;
    } else {
      authMode = AuthMode.login;
    }
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _hidePassword = !_hidePassword;
    notifyListeners();
  }

  void _setAuthState(LoadState state, {bool build = true}) {
    _authState = state;
    if (build) {
      notifyListeners();
    }
  }
}
