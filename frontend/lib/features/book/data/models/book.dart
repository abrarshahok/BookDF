// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'book.freezed.dart';
part 'book.g.dart';

@freezed
class Book with _$Book {
  const factory Book({
    @JsonKey(name: '_id') String? id,
    String? title,
    String? author,
    String? description,
    String? genre,
    int? pages,
    String? coverImage,
    String? pdf,
    Ratings? ratings,
    List<dynamic>? reviews,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}

@freezed
class Ratings with _$Ratings {
  const factory Ratings({
    required double averageRating,
    required int numberOfRatings,
  }) = _Ratings;

  factory Ratings.fromJson(Map<String, dynamic> json) =>
      _$RatingsFromJson(json);
}
