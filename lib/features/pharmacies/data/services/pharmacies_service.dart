import '../repositories/pharmacies_repository.dart';

class PharmaciesService {
  const PharmaciesService({ this.repository = const PharmaciesRepository() });

  final PharmaciesRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
