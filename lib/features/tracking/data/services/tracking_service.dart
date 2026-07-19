import '../repositories/tracking_repository.dart';

class TrackingService {
  const TrackingService({ this.repository = const TrackingRepository() });

  final TrackingRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();
  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
