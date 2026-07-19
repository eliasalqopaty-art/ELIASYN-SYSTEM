import '../repositories/wholesales_repository.dart';

class WholesalesService {
  const WholesalesService({ this.repository = const WholesalesRepository() });

  final WholesalesRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
