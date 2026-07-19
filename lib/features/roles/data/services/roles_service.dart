import '../repositories/roles_repository.dart';

class RolesService {
  const RolesService({ this.repository = const RolesRepository() });

  final RolesRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
