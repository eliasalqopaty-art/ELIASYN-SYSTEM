import '../repositories/medicines_repository.dart';

class MedicinesService {
  const MedicinesService({ this.repository = const MedicinesRepository() });

  final MedicinesRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
