import 'dart:developer';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import '../dependency_injection/dependency_injection.dart';
import '../features/library/data/respository/library_repository.dart';
import '../states/load_state.dart';
import '/providers/auth_repository_provider.dart';
import '/utils/show_toast.dart';

@lazySingleton
class LibraryBooksProvider with ChangeNotifier {
  LoadState _state = InitialState();
  LoadState get state => _state;

  File? coverImage;
  File? pdfFile;

  void fetchBooks() async {
    _setState(LoadingState(), build: false);

    final result = await LibraryRepository.instance.fetchBooks();

    result.fold(
      (error) => _setState(ErrorState(error)),
      (books) => _setState(SuccessState(books)),
    );
  }

  void addBook({
    required String title,
    required String author,
    required String description,
    required String genre,
    required File? coverImage,
    required File? pdf,
    required BuildContext context,
  }) async {
    if (coverImage == null) {
      return showToast('Please Choose Cover Image!', context, isError: true);
    }

    if (pdf == null) {
      return showToast('Please Choose Book PDF!', context, isError: true);
    }

    _setState(LoadingState());

    final result = await LibraryRepository.instance.addBook(
      title: title,
      author: author,
      description: description,
      genre: genre,
      coverImage: coverImage,
      pdf: pdf,
    );

    result.fold((error) {
      showToast('Book failed to save!', context, isError: true);
      _setState(ErrorState(error));
    }, (books) {
      _setState(SuccessState(books));
      Navigator.pop(context);
      showToast('Book Added Successfully!', context);
    });
  }

  void updateBook({
    required String title,
    required String author,
    required String description,
    required String genre,
    required File? coverImage,
    required File? pdf,
    required String bookId,
    required BuildContext context,
  }) async {
    _setState(LoadingState());

    log(coverImage!.path);

    final result = await LibraryRepository.instance.updateBook(
      title: title,
      author: author,
      description: description,
      genre: genre,
      coverImage: coverImage,
      pdf: pdf,
      bookId: bookId,
    );

    result.fold((error) {
      showToast('Book failed to save!', context, isError: true);
      log(error);
      _setState(ErrorState(error));
    }, (books) {
      _setState(SuccessState(books));
      Navigator.pop(context);
      showToast('Book Updated Successfully!', context);
    });
  }

  void deleteBook(
    String bookId,
    BuildContext context,
  ) async {
    final result = await LibraryRepository.instance.deleteBook(bookId);

    result.fold(
      (error) {
        context.router.maybePop();
        showToast('Book failed to delete!', context, isError: true);
      },
      (books) {
        _setState(SuccessState(books));
        locator<AuthRepositoryProvider>().deleteReadingSession(bookId);
        showToast('Book deleted Successfully', context);
      },
    );
  }

  void _setState(LoadState newState, {bool build = true}) {
    _state = newState;
    if (build) {
      notifyListeners();
    }
  }

  void selectImage(File image) {
    coverImage = image;
    notifyListeners();
  }

  Future<void> selectPdf(File pdf) async {
    pdfFile = pdf;
    notifyListeners();
  }
}
