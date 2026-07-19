class LocalStorageService {
  const LocalStorageService();

  Future<Map<String, dynamic>> load(String key) async => <String, dynamic>{};
  Future<void> save(String key, Map<String, dynamic> data) async {}
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
