// ignore_for_file: invalid_annotation_target
import 'package:bookdf/features/book/data/models/book.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'reading_session.freezed.dart';
part 'reading_session.g.dart';

@freezed
class ReadingSession with _$ReadingSession {
  factory ReadingSession({
    @JsonKey(name: '_id') required String id,
    required String userId,
    required String bookId,
    required int currentPage,
    required int totalPages,
    required Book bookDetails,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ReadingSession;

  factory ReadingSession.fromJson(Map<String, dynamic> json) =>
      _$ReadingSessionFromJson(json);
}
