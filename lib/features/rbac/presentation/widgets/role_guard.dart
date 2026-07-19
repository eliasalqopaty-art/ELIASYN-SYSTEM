import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/rbac_providers.dart';

class RoleGuard extends ConsumerWidget {
  const RoleGuard({
    super.key,
    required this.requiredRoles,
    this.fallback,
    required this.child,
  });

  final List<String> requiredRoles;
  final Widget child;
  final Widget? fallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canAccess = ref.watch(roleGuardProvider(requiredRoles));
    return canAccess ? child : fallback ?? const SizedBox.shrink();
  }
}
