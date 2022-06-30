import 'package:flutter/material.dart';

class FieldProvider extends ChangeNotifier {
  late bool _isNameFieldEmpty = true;
  bool get isNameFieldEmpty => _isNameFieldEmpty;

  late bool _isNumberFieldEmpty = true;
  bool get isNumberFieldEmpty => _isNumberFieldEmpty;

  int _fieldState = 0;
  int get fieldState => _fieldState;

  setFieldState(int state) {
    _fieldState = state;
    notifyListeners();
  }

  getIsNameFieldEmpty(bool isEmpty) {
    _isNameFieldEmpty = isEmpty;
    notifyListeners();
  }

  getIsNumberFieldEmpty(bool isEmpty) {
    _isNumberFieldEmpty = isEmpty;
    notifyListeners();
  }
}
