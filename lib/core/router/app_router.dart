import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../modules/auth/presentation/pages/login_page.dart';
import '../../modules/dashboard/presentation/pages/dashboard_page.dart';
import '../../screens/splash_screen.dart';

class AppSession extends ChangeNotifier {
  static final AppSession instance = AppSession();

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  refreshListenable: AppSession.instance,
  redirect: (context, state) {
    final loggedIn = AppSession.instance.isLoggedIn;
    final loc = state.uri.path;

    final isLogin = loc == '/login';
    final isSplash = loc == '/splash';

    if (isSplash) return null;

    if (!loggedIn && !isLogin) return '/login';

    if (loggedIn && isLogin) return '/dashboard';

    return null;
  },
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
  ],
);
import 'package:flutter_riverpod/flutter_riverpod.dart';
