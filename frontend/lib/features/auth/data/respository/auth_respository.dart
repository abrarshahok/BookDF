import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bookdf/features/auth/data/models/user.dart';
import 'package:dartz/dartz.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as h;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/http_config.dart';
import '../../../../utils/failure.dart';

class AuthRepository {
  AuthRepository._();

  static final AuthRepository instance = AuthRepository._();

  String? _jwt;

  String? get jwt => _jwt;

  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<Either<Failure, bool>> signup({
    required String username,
    required String email,
    required String password,
    required File image,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/signup/');
      var request = h.MultipartRequest('POST', uri);

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      request.fields['username'] = username;
      request.fields['email'] = email;
      request.fields['password'] = password;

      final mimeType = lookupMimeType(image.path);
      final mediaType = mimeType != null
          ? MediaType.parse(mimeType)
          : MediaType('application', 'octet-stream');

      final multipartFile = await h.MultipartFile.fromPath(
        'pic',
        image.path,
        contentType: mediaType,
      );
      request.files.add(multipartFile);

      final response = await request.send();

      final responseString = await h.Response.fromStream(response);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(responseString.body);
        if (responseBody['success']) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwt', responseBody['jwt']);
          return const Right(true);
        }
      }
      return const Right(false);
    } catch (e) {
      return Left(Failure('Signup error: $e'));
    }
  }

  Future<Either<Failure, bool>> signin({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/signin/');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseBody['success']) {
          final prefs = await SharedPreferences.getInstance();
          _jwt = responseBody['jwt'];
          await prefs.setString('jwt', _jwt!);
          bool isSuccess = await getUser(jwt!);
          return Right(isSuccess);
        }
      }

      return const Right(false);
    } catch (e) {
      return Left(Failure('Signin error: $e'));
    }
  }

  Future<bool> getUser(String jwt) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/user/');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          _currentUser = User.fromJson(responseBody['user']);
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Either<Failure, String>> updateUser(
    String username,
    File? image,
  ) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/user/');
      var request = h.MultipartRequest('PATCH', uri);

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $jwt'
      });

      request.fields['username'] = username;

      if (image != null) {
        final mimeType = lookupMimeType(image.path);
        final mediaType = mimeType != null
            ? MediaType.parse(mimeType)
            : MediaType('application', 'octet-stream');

        final multipartFile = await h.MultipartFile.fromPath(
          'pic',
          image.path,
          contentType: mediaType,
        );
        request.files.add(multipartFile);
      }

      final response = await request.send();

      final responseString = await h.Response.fromStream(response);

      final responseBody = jsonDecode(responseString.body);

      if (response.statusCode == 200) {
        if (responseBody['success']) {
          _currentUser = User.fromJson(responseBody['user']);
          return Right(responseBody['message']);
        }
      }

      return Left(Failure(responseBody['message']));
    } catch (e) {
      return Left(Failure('Updating User error: $e'));
    }
  }

  void addReadingSession(String bookId) {
    _currentUser = _currentUser!.copyWith(
      currentReadings: [...?_currentUser!.currentReadings, bookId],
    );
  }

  void deleteReadingSession(String bookId) {
    final List<String> newReadingSessionList =
        List.from(_currentUser!.currentReadings ?? []);

    if (newReadingSessionList.isNotEmpty) {
      newReadingSessionList.remove(bookId);

      _currentUser =
          _currentUser!.copyWith(currentReadings: newReadingSessionList);
    }
  }

  void toggleBookmarks(String bookId) {
    final List<String> newBookmarksList = List.from(_currentUser!.bookmarks!);

    if (newBookmarksList.contains(bookId)) {
      newBookmarksList.remove(bookId);
      _currentUser = _currentUser!.copyWith(bookmarks: newBookmarksList);
    } else {
      newBookmarksList.add(bookId);
      _currentUser = _currentUser!.copyWith(bookmarks: newBookmarksList);
    }
  }

  Future<Either<Failure, bool>> autoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _jwt = prefs.getString('jwt');
      if (_jwt != null) {
        bool isSuccess = await getUser(jwt!);
        return Right(isSuccess);
      }

      return const Right(false);
    } catch (_) {
      log(_.toString());
      return Left(Failure('Something went wrong!'));
    }
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
  }
}
