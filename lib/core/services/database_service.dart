class DatabaseService {
  const DatabaseService();

  Future<List<Map<String, dynamic>>> fetch(String table) async => [];
  Future<void> upsert(String table, Map<String, dynamic> item) async {}
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
