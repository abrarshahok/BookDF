import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../../../config/http_config.dart';
import '/features/book/data/models/reading_session.dart';

class ReadingSessionsRepository {
  ReadingSessionsRepository._();

  static final ReadingSessionsRepository instance =
      ReadingSessionsRepository._();

  List<ReadingSession> _readingSessions = [];
  List<ReadingSession> get readingSessions => _readingSessions;

  Future<Either<String, List<ReadingSession>>> fetchReadingSessions(
    String jwt,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/readingSessions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final List<ReadingSession> readingSessionsData =
            (responseData['sessions'] as List<dynamic>)
                .map((session) => ReadingSession.fromJson(session))
                .toList();
        _readingSessions = readingSessionsData;
        return Right(readingSessionsData);
      }

      return const Left('Failed to Load Reading Sessions');
    } catch (err) {
      return Left(err.toString());
    }
  }

  Future<Either<String, List<ReadingSession>>> createSession(
    String jwt,
    String bookId,
    int totalPages,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/readingSessions/$bookId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonEncode({
          'totalPages': totalPages,
        }),
      );
      log(response.toString());
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final ReadingSession newSession =
            ReadingSession.fromJson(responseData['session']);
        _readingSessions.insert(0, newSession);
        return Right(_readingSessions);
      }
      return Left(jsonDecode(response.body)['message']);
    } catch (err) {
      return Left(err.toString());
    }
  }

  Future<Either<String, List<ReadingSession>>> updateSession(
    String jwt,
    String sessionId,
    int currentPage,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/readingSessions/$sessionId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonEncode({
          'currentPage': currentPage,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final updatedPages = responseData['session']['currentPage'];

        final index =
            _readingSessions.indexWhere((session) => session.id == sessionId);

        if (index != -1) {
          _readingSessions[index] =
              _readingSessions[index].copyWith(currentPage: updatedPages);
        }

        return Right(_readingSessions);
      }

      return Left(jsonDecode(response.body)['message']);
    } catch (err) {
      return Left(err.toString());
    }
  }
}
