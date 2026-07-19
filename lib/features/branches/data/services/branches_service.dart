import '../repositories/branches_repository.dart';

class BranchesService {
  const BranchesService({ this.repository = const BranchesRepository() });

  final BranchesRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
