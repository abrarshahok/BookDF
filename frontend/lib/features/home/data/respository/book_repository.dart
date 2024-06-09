import 'dart:convert';
import 'package:bookdf/config/http_config.dart';
import 'package:bookdf/features/home/data/models/book.dart';
import 'package:dartz/dartz.dart';
// import 'package:http/http.dart' as http;

class BookRepository {
  BookRepository._();

  static final BookRepository instance = BookRepository._();

  Future<Either<String, List<Book>>> fetchBooks(String jwt) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/books'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final List<Book> bookData = (responseData['books'] as List<dynamic>)
            .map((book) => Book.fromJson(book))
            .toList();
        return Right(bookData);
      }

      return const Left('Failed to Load Books');
    } catch (err) {
      return const Left('Something went wrong!');
    }
  }
}
