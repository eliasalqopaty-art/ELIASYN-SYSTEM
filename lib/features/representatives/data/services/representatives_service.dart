import '../repositories/representatives_repository.dart';

class RepresentativesService {
  const RepresentativesService({ this.repository = const RepresentativesRepository() });

  final RepresentativesRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
