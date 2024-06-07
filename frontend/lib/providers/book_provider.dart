import 'package:flutter/material.dart';
import '../features/home/presentation/state/book_state.dart';
import '/features/home/data/respository/book_repository.dart';

class BookProvider with ChangeNotifier {
  BookState _state = InitialState();
  BookState get state => _state;

  void fetchBooks() async {
    _setState(LoadingState(), build: false);

    final result = await BookRepository.instance.fetchBooks();

    result.fold(
      (error) => _setState(ErrorState(error)),
      (books) => _setState(SuccessState(books)),
    );
  }

  void _setState(BookState newState, {bool build = true}) {
    _state = newState;
    if (build) {
      notifyListeners();
    }
  }
}
