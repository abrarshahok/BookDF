import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../states/load_state.dart';
import '../features/book/data/respository/book_repository.dart';

@lazySingleton
class BookRepositoryProvider with ChangeNotifier {
  LoadState _bookState = InitialState();
  LoadState get bookState => _bookState;

  LoadState _searchState = InitialState();
  LoadState get searchState => _searchState;

  void fetchBooks(String genre) async {
    _setBookState(LoadingState(), build: false);

    final result = await BookRepository.instance.fetchBooks(genre);

    result.fold(
      (error) => _setBookState(ErrorState(error)),
      (books) => _setBookState(SuccessState(books)),
    );
  }

  void fetchBookmarkedBooks() async {
    _setBookState(LoadingState(), build: false);

    final result = await BookRepository.instance.fetchBookmarkedBooks();

    result.fold(
      (error) => _setBookState(ErrorState(error)),
      (books) => _setBookState(SuccessState(books)),
    );
  }

  void searchBooks(String title) async {
    _setSearchState(LoadingState());

    final result = await BookRepository.instance.searchBooks(title);

    result.fold(
      (error) => _setSearchState(ErrorState(error)),
      (books) => _setSearchState(SuccessState(books)),
    );
  }

  void _setSearchState(LoadState state, {bool build = true}) {
    _searchState = state;
    if (build) {
      notifyListeners();
    }
  }

  void _setBookState(LoadState newState, {bool build = true}) {
    _bookState = newState;
    if (build) {
      notifyListeners();
    }
  }
}
