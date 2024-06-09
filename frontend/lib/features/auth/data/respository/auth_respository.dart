import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bookdf/features/auth/data/models/user.dart';
import 'package:dartz/dartz.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
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
      var request = http.MultipartRequest('POST', uri);

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

      final multipartFile = await http.MultipartFile.fromPath(
        'pic',
        image.path,
        contentType: mediaType,
      );
      request.files.add(multipartFile);

      final response = await request.send();

      final responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        final responseData = json.decode(responseBody.body);
        await prefs.setString('jwt', responseData['jwt']);
        return const Right(true);
      } else {
        return Left(Failure('Signup failed: ${response.statusCode}'));
      }
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
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        _jwt = responseBody['jwt'];

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('jwt', _jwt!);

        await getUser(jwt!);

        return const Right(true);
      } else {
        return Left(Failure('Signin failed: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(Failure('Signin error: $e'));
    }
  }

  Future<void> getUser(String jwt) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/get-user/');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        _currentUser = User.fromJson(responseBody['user']);
      } else {
        _currentUser = null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<Failure, bool>> autoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _jwt = prefs.getString('jwt');
      if (_jwt != null) {
        log(_jwt!);
        await getUser(jwt!);
        return const Right(true);
      } else {
        return const Right(false);
      }
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
