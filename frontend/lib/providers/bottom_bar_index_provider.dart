import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BottomBarIndexProvider with ChangeNotifier {
  int _index = 0;

  int get index => _index;

  void set(int newValue) {
    _index = newValue;
    notifyListeners();
  }
}
