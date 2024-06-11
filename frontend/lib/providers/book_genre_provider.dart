import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BookGenreProvider with ChangeNotifier {
  String _genre = 'All';

  String get genre => _genre;

  void set(String category) {
    _genre = category;
    notifyListeners();
  }
}
