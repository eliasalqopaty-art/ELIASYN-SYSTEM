import '../repositories/reports_repository.dart';

class ReportsService {
  const ReportsService({ this.repository = const ReportsRepository() });

  final ReportsRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
