import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../states/load_state.dart';
import '../features/book/data/respository/book_repository.dart';

@lazySingleton
class BookRepositoryProvider with ChangeNotifier {
  LoadState _state = InitialState();
  LoadState get state => _state;

  void fetchBooks(String genre) async {
    _setState(LoadingState(), build: false);

    final result = await BookRepository.instance.fetchBooks(genre);

    result.fold(
      (error) => _setState(ErrorState(error)),
      (books) => _setState(SuccessState(books)),
    );
  }

  void fetchBookmarkedBooks() async {
    _setState(LoadingState(), build: false);

    final result = await BookRepository.instance.fetchBookmarkedBooks();

    result.fold(
      (error) => _setState(ErrorState(error)),
      (books) => _setState(SuccessState(books)),
    );
  }

  void _setState(LoadState newState, {bool build = true}) {
    _state = newState;
    if (build) {
      notifyListeners();
    }
  }
}
