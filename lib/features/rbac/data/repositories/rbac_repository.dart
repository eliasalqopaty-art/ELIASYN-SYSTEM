import '../../../../core/services/supabase_service.dart';
import '../../domain/models/permission_model.dart';
import '../../domain/models/role_model.dart';

class RbacRepository {
  const RbacRepository({this.supabaseService = const SupabaseService()});

  final SupabaseService supabaseService;

  Future<List<RoleModel>> fetchRoles() async {
    await supabaseService.ping();
    return const [
      RoleModel(
          code: 'admin', label: 'Admin', description: 'Full system access'),
      RoleModel(
          code: 'manager',
          label: 'Manager',
          description: 'Operational control'),
      RoleModel(
          code: 'auditor',
          label: 'Auditor',
          description: 'Read-only audit access'),
      RoleModel(
          code: 'viewer',
          label: 'Viewer',
          description: 'Read-only dashboard access'),
    ];
  }

  Future<List<PermissionModel>> fetchPermissions() async {
    await supabaseService.ping();
    return const [
      PermissionModel(
          code: 'dashboard.view',
          label: 'View Dashboard',
          description: 'Open dashboard'),
      PermissionModel(
          code: 'inventory.manage',
          label: 'Manage Inventory',
          description: 'Modify inventory'),
      PermissionModel(
          code: 'reports.view',
          label: 'View Reports',
          description: 'Open reports'),
      PermissionModel(
          code: 'users.manage',
          label: 'Manage Users',
          description: 'Manage user roles'),
    ];
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
