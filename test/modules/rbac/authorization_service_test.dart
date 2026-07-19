import 'package:alasim_management/features/rbac/data/services/authorization_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AuthorizationService allows access for matching roles', () {
    const service = AuthorizationService();

    expect(service.canAccess(const ['manager'], const ['admin', 'manager']),
        isTrue);
    expect(service.canAccess(const ['viewer'], const ['admin']), isFalse);
  });
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
