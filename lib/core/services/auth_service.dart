class AuthService {
  const AuthService();

  Future<bool> signIn({required String email, required String password}) async {
    return email.isNotEmpty && password.isNotEmpty;
  }

  Future<void> signOut() async {}
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
