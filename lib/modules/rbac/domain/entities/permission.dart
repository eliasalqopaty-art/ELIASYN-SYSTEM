enum Permission {
  dashboardView,
  usersManage,
  pharmaciesManage,
  warehousesManage,
  inventoryManage,
  representativesManage,
  distributorsManage,
  factoriesManage,
  wholesaleManage,
  trackingView,
  reportsView,
  auditView,
  syncManage,
  notificationsManage,
}

class RolePolicy {
  static const Map<String, Set<Permission>> permissionsByRole = {
    'admin': {...Permission.values},
    'manager': {
      Permission.dashboardView,
      Permission.pharmaciesManage,
      Permission.warehousesManage,
      Permission.inventoryManage,
      Permission.representativesManage,
      Permission.distributorsManage,
      Permission.factoriesManage,
      Permission.wholesaleManage,
      Permission.trackingView,
      Permission.reportsView,
      Permission.notificationsManage,
    },
    'auditor': {
      Permission.dashboardView,
      Permission.reportsView,
      Permission.auditView,
    },
    'sales': {
      Permission.dashboardView,
      Permission.pharmaciesManage,
      Permission.representativesManage,
      Permission.trackingView,
    },
    'viewer': {
      Permission.dashboardView,
      Permission.reportsView,
    },
  };

  static bool allows(List<String> roles, Permission permission) {
    return roles.any(
      (role) => permissionsByRole[role]?.contains(permission) ?? false,
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
