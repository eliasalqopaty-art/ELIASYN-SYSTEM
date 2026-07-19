import '../repositories/fingerprint_repository.dart';

class FingerprintService {
  const FingerprintService({this.repository = const FingerprintRepository()});

  final FingerprintRepository repository;

  Future<List<Map<String, dynamic>>> load() => repository.fetchAll();

  Future<Map<String, dynamic>> read(String id) => repository.fetchById(id);

  Future<Map<String, dynamic>> mockVerify(String type, String id) async {
    return {
      'status': 'mock',
      'method': type,
      'verified': false,
      'targetId': id,
      'message':
          'Placeholder verification only; real SDK integration is pending.',
    };
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
