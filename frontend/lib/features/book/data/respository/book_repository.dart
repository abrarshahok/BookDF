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

  final _jwt = AuthRepository.instance.jwt!;

  Future<Either<String, List<Book>>> fetchBooks() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/books'),
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
}
