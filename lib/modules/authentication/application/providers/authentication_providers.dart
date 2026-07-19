import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../users/application/providers/users_controller.dart';
import '../../domain/entities/auth_session.dart';

final currentSessionProvider = Provider<AuthSession?>((ref) {
  final auth = ref.watch(authControllerProvider);
  final user = auth.currentUser;
  if (user == null) return null;

  return AuthSession(
    userId: user.id,
    email: user.email,
    roles: user.roles,
    startedAt: user.updatedAt,
  );
});
