import 'package:flutter_riverpod/legacy.dart';

class AuthState {
  final bool isLoading;
  final String? errorMessage;

  AuthState({this.isLoading = false, this.errorMessage});
}

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(AuthState());

  Future<bool> login(String email, String password) async {
    state = AuthState(isLoading: true);

    await Future.delayed(const Duration(seconds: 1));

    if (email == 'admin@alasim.local' && password == 'admin123') {
      state = AuthState(isLoading: false);
      return true;
    }

    state = AuthState(
      isLoading: false,
      errorMessage: 'بيانات الدخول غير صحيحة',
    );

    return false;
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(),
);
