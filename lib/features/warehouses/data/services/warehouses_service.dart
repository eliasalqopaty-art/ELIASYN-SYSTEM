import '../repositories/warehouses_repository.dart';

class WarehousesService {
  const WarehousesService({ this.repository = const WarehousesRepository() });

  final WarehousesRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
