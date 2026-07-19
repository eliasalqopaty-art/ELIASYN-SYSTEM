import '../repositories/factories_repository.dart';

class FactoriesService {
  const FactoriesService({ this.repository = const FactoriesRepository() });

  final FactoriesRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
