import 'package:alasim_management/modules/authentication/domain/entities/auth_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AuthSession serializes and restores roles', () {
    final session = AuthSession(
      userId: 'u1',
      email: 'admin@alasim.local',
      roles: const ['admin', 'manager'],
      startedAt: DateTime.utc(2026, 6, 1),
    );

    final restored = AuthSession.fromMap(session.toMap());

    expect(restored.userId, 'u1');
    expect(restored.email, 'admin@alasim.local');
    expect(restored.roles, ['admin', 'manager']);
    expect(restored.startedAt, DateTime.utc(2026, 6, 1));
  });
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
