import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../modules/users/application/providers/users_controller.dart';
import '../../data/repositories/rbac_repository.dart';
import '../../data/services/authorization_service.dart';

final rbacRepositoryProvider = Provider<RbacRepository>(
  (ref) => const RbacRepository(),
);

final authorizationServiceProvider = Provider<AuthorizationService>(
  (ref) => AuthorizationService(repository: ref.watch(rbacRepositoryProvider)),
);

final roleGuardProvider =
    Provider.family<bool, List<String>>((ref, requiredRoles) {
  final user = ref.watch(authControllerProvider).currentUser;
  final service = ref.watch(authorizationServiceProvider);
  return service.canAccess(user?.roles ?? const <String>[], requiredRoles);
});
