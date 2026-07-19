import '../repositories/audit_repository.dart';

class AuditService {
  const AuditService({ this.repository = const AuditRepository() });

  final AuditRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
