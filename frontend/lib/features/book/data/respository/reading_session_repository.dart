import 'dart:convert';
import 'dart:developer';

import 'package:bookdf/features/book/data/models/reading_session.dart';
import 'package:dartz/dartz.dart';

import '../../../../config/http_config.dart';

class ReadingSessionsRepository {
  ReadingSessionsRepository._();

  static final ReadingSessionsRepository instance =
      ReadingSessionsRepository._();

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
        return Right(readingSessionsData);
      }

      return const Left('Failed to Load Books');
    } catch (err) {
      log(err.toString());
      return Left(err.toString());
    }
  }
}
