class AppSession {
  AppSession._privateConstructor();
  static final AppSession instance = AppSession._privateConstructor();

  bool _loggedIn = false;

  void login() {
    _loggedIn = true;
  }

  void logout() {
    _loggedIn = false;
  }

  bool get isLoggedIn => _loggedIn;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
