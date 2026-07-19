class FingerprintRepository {
  const FingerprintRepository();

  Future<List<Map<String, dynamic>>> fetchAll() async => const <Map<String, dynamic>>[];
  Future<Map<String, dynamic>> fetchById(String id) async => <String, dynamic>{'id': id};
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
