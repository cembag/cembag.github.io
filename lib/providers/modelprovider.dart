import 'package:flutter/material.dart';

class ModelProvider extends ChangeNotifier {
  int _signState = 0;
  int get signState => _signState;

  toggleSignState() {
    _signState == 1 ? _signState = 0 : _signState = 1;
    notifyListeners();
  }

  bool _isMenuOpen = false;
  bool get isMenuOpen => _isMenuOpen;

  toggleMenu() {
    _isMenuOpen = !_isMenuOpen;
    notifyListeners();
  }
}
