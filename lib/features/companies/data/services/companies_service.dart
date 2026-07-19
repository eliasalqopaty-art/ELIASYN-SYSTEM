import '../repositories/companies_repository.dart';

class CompaniesService {
  const CompaniesService({ this.repository = const CompaniesRepository() });

  final CompaniesRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
