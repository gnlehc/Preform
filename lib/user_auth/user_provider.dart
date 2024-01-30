import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _userEmail;

  String? get userEmail => _userEmail;

  void setUserEmail(String? email) {
    _userEmail = email;
    notifyListeners();
  }
}
