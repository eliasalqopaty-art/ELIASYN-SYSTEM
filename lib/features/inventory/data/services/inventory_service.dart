import '../../domain/models/inventory_item.dart';
import '../repositories/inventory_repository.dart';

class InventoryService {
  const InventoryService({this.repository = const InventoryRepository()});

  final InventoryRepository repository;

  Future<List<InventoryItem>> load() => repository.fetchAll();

  Future<InventoryItem?> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
