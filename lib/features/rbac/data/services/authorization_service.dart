import '../../data/repositories/rbac_repository.dart';

class AuthorizationService {
  const AuthorizationService({this.repository = const RbacRepository()});

  final RbacRepository repository;

  bool canAccess(List<String> userRoles, List<String> requiredRoles) {
    if (requiredRoles.isEmpty) return true;
    return requiredRoles.any(userRoles.contains);
  }

  Future<List<String>> availableRoles() async {
    final roles = await repository.fetchRoles();
    return roles.map((role) => role.code).toList();
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
