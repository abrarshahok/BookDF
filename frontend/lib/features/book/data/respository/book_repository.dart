import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import '/config/http_config.dart';
import '/features/book/data/models/book.dart';
import '/features/auth/data/respository/auth_respository.dart';
// import 'package:http/http.dart' as http;

class BookRepository {
  BookRepository._();

  static final BookRepository instance = BookRepository._();

  List<Book> _books = [];
  List<Book> get books => _books;

  List<Book> _bookmarkBooks = [];
  List<Book> get bookmarkBooks => _bookmarkBooks;

  final _jwt = AuthRepository.instance.jwt!;

  Future<Either<String, List<Book>>> fetchBooks(String genre) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/books?genre=$genre'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_jwt'
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final List<Book> bookData = (responseData['books'] as List<dynamic>)
            .map((book) => Book.fromJson(book))
            .toList();
        _books = bookData;
        return Right(bookData);
      }

      return const Left('Failed to Load Books');
    } catch (err) {
      log(err.toString());
      return const Left('Something went wrong!');
    }
  }

  Future<Either<String, List<Book>>> searchBooks(String title) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/books/search?title=$title'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_jwt'
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final List<Book> bookData = (responseData['books'] as List<dynamic>)
            .map((book) => Book.fromJson(book))
            .toList();
        _books = bookData;
        return Right(bookData);
      }

      return const Left('Failed to Load Books');
    } catch (err) {
      log(err.toString());
      return const Left('Something went wrong!');
    }
  }

  Future<Either<String, String>> toggleBookmarks(String bookId) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/books/toggleBookmarks/$bookId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_jwt'
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          return Right(responseBody['message']);
        }
      }

      return const Left('Something went wrong!');
    } catch (err) {
      log(err.toString());
      return const Left('Something went wrong!');
    }
  }

  Future<Either<String, List<Book>>> fetchBookmarkedBooks() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/books/bookmarks'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_jwt'
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final List<Book> bookData = (responseData['books'] as List<dynamic>)
            .map((book) => Book.fromJson(book))
            .toList();

        _bookmarkBooks = bookData;

        return Right(bookData);
      }

      return const Left('Something went wrong!');
    } catch (err) {
      log(err.toString());
      return const Left('Something went wrong!');
    }
  }
}
