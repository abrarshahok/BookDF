// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    String? id,
    String? username,
    String? email,
    String? pic,
    @Default([]) List<String>? library,
    @Default([]) List<String>? bookmarks,
    @Default([]) List<String>? currentReadings,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
