import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weloggerweb/services/services.dart';

class UserProvider extends ChangeNotifier {
  String _userName = '';
  String get userName => _userName;

  User? _user;
  User? get user => _user;

  getUser(user) {
    _user = user;
    notifyListeners();
  }

  Future<void> getName(uid) async {
    _userName = await DbService().getUserInfo(uid);
    notifyListeners();
  }
}
