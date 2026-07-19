import 'package:go_router/go_router.dart';

import '../../modules/auth/presentation/pages/login_page.dart';
import '../../modules/dashboard/presentation/pages/dashboard_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
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
