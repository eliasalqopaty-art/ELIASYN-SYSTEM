import '../repositories/batches_repository.dart';

class BatchesService {
  const BatchesService({ this.repository = const BatchesRepository() });

  final BatchesRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
