import 'dart:convert';
import 'dart:developer';
import 'dart:io';
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

  Future<Either<Failure, bool>> signup({
    required String username,
    required String email,
    required String password,
    required File image,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/signup/');
      var request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      // Add text fields
      request.fields['username'] = username;
      request.fields['email'] = email;
      request.fields['password'] = password;

      // Determine the MIME type of the file
      var mimeType = lookupMimeType(image.path);
      var mediaType = mimeType != null
          ? MediaType.parse(mimeType)
          : MediaType('application', 'octet-stream');

      // Add file field
      var multipartFile = await http.MultipartFile.fromPath(
        'pic',
        image.path,
        contentType: mediaType,
      );
      request.files.add(multipartFile);

      // Send request
      var response = await request.send();

      // Convert streamed response to full response
      final responseBody = await http.Response.fromStream(response);

      // Handle response
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        final responseData = json.decode(responseBody.body);
        log(responseData.toString());
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
        log(responseBody.toString());
        return const Right(true);
      } else {
        return Left(Failure('Signin failed: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(Failure('Signin error: $e'));
    }
  }
}
