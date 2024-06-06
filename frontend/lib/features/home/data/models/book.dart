import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@freezed
class Book with _$Book {
  const factory Book({
    required String title,
    required String author,
    required String description,
    required String genre,
    required int pages,
    required CoverImage coverImage,
    required Pdf pdf,
    required Ratings ratings,
    required List<String> reviews,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}

@freezed
class CoverImage with _$CoverImage {
  const factory CoverImage({
    required List<int> data,
    required String contentType,
  }) = _CoverImage;

  factory CoverImage.fromJson(Map<String, dynamic> json) =>
      _$CoverImageFromJson(json);
}

@freezed
class Pdf with _$Pdf {
  const factory Pdf({
    required String filename,
    required List<int> data,
    required String contentType,
  }) = _Pdf;

  factory Pdf.fromJson(Map<String, dynamic> json) => _$PdfFromJson(json);
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
