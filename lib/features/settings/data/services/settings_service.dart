import '../repositories/settings_repository.dart';

class SettingsService {
  const SettingsService({ this.repository = const SettingsRepository() });

  final SettingsRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
