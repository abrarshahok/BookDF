import 'dart:convert';
import 'dart:developer';

import 'package:bookdf/config/http_config.dart';
import 'package:bookdf/features/home/data/models/book.dart';
import 'package:dartz/dartz.dart';

class BookRepository {
  BookRepository._();

  static final BookRepository instance = BookRepository._();

  Future<Either<String, List<Book>>> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse('/books'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final List<Book> bookData =
            responseData['books'].map((book) => Book.fromJson(book));
        log(bookData.toString());
        return Right(bookData);
      }

      return const Left('Failed to Load Books');
    } catch (err) {
      log(err.toString());
      return const Left('Something went wrong!');
    }
  }
}
