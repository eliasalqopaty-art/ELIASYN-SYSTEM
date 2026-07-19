import '../repositories/ai_assistant_repository.dart';

class AiAssistantService {
  const AiAssistantService({ this.repository = const AiAssistantRepository() });

  final AiAssistantRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
