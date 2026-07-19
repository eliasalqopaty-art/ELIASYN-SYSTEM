import '../repositories/distributors_repository.dart';

class DistributorsService {
  const DistributorsService({ this.repository = const DistributorsRepository() });

  final DistributorsRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
