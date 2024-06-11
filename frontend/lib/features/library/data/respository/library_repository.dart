import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as h;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../config/http_config.dart';
import '../../../auth/data/respository/auth_respository.dart';
import '../../../book/data/models/book.dart';

class LibraryRepository {
  LibraryRepository._();

  static final LibraryRepository instance = LibraryRepository._();

  final _jwt = AuthRepository.instance.jwt!;

  List<Book> _books = [];

  List<Book> get books => _books;

  Future<Either<String, List<Book>>> fetchBooks() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/books/library'),
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

  Future<Either<String, List<Book>>> addBook({
    required String title,
    required String author,
    required String description,
    required String genre,
    required File coverImage,
    required File pdf,
  }) async {
    try {
      final request =
          h.MultipartRequest('POST', Uri.parse('$baseUrl/books/add-book'));

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $_jwt',
      });

      request.fields['title'] = title;
      request.fields['author'] = author;
      request.fields['description'] = description;
      request.fields['genre'] = genre;

      // Adding cover image file
      final coverImageMimeType = lookupMimeType(coverImage.path);
      final coverImageFile = await h.MultipartFile.fromPath(
        'coverImage',
        coverImage.path,
        contentType: MediaType.parse(coverImageMimeType!),
      );
      request.files.add(coverImageFile);

      // Adding PDF file
      final pdfMimeType = lookupMimeType(pdf.path);
      final pdfFile = await h.MultipartFile.fromPath(
        'pdf',
        pdf.path,
        contentType: MediaType.parse(pdfMimeType!),
      );
      request.files.add(pdfFile);

      log(request.fields.toString());

      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(responseString);
        final Book newBook = Book.fromJson(responseBody['book']);
        _books.insert(0, newBook);
        return Right(_books);
      } else {
        return const Left('Failed to add book');
      }
    } catch (err) {
      log(err.toString());
      return const Left('Something went wrong!');
    }
  }

  Future<Either<String, List<Book>>> deleteBook(String bookId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/books/$bookId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_jwt'
        },
      );

      if (response.statusCode == 200) {
        _books.removeWhere((book) => book.id == bookId);
        return Right(_books);
      }

      return const Left('Failed to delete!');
    } catch (err) {
      log(err.toString());
      return const Left('Something went wrong!');
    }
  }
}
