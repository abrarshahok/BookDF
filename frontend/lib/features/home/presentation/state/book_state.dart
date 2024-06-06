import '../../data/models/book.dart';

abstract class BookState {}

class InitialState extends BookState {}

class LoadingState extends BookState {}

class SuccessState extends BookState {
  final List<Book> books;

  SuccessState(this.books);
}

class ErrorState extends BookState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}
