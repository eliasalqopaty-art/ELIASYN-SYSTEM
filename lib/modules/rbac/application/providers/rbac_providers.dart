import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../users/application/providers/users_controller.dart';
import '../../domain/entities/permission.dart';

final permissionProvider = Provider.family<bool, Permission>((ref, permission) {
  final user = ref.watch(authControllerProvider).currentUser;
  if (user == null) return false;
  return RolePolicy.allows(user.roles, permission);
});
