import 'package:alasim_management/modules/rbac/domain/entities/permission.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RolePolicy', () {
    test('admin can access every permission', () {
      for (final permission in Permission.values) {
        expect(RolePolicy.allows(['admin'], permission), isTrue);
      }
    });

    test('viewer has read-only dashboard and reports access', () {
      expect(RolePolicy.allows(['viewer'], Permission.dashboardView), isTrue);
      expect(RolePolicy.allows(['viewer'], Permission.reportsView), isTrue);
      expect(RolePolicy.allows(['viewer'], Permission.usersManage), isFalse);
    });
  });
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
