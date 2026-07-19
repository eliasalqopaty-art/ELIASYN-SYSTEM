import '../config/app_config.dart';

class SupabaseService {
  const SupabaseService();

  bool get isConfigured =>
      AppConfig.supabaseUrl.startsWith('https://') &&
      AppConfig.supabaseAnonKey.isNotEmpty &&
      AppConfig.supabaseAnonKey != 'replace-with-your-anon-key';

  Future<void> initialize() async {}

  Future<Map<String, dynamic>> ping() async => {
        'status': 'placeholder',
        'message':
            'Supabase placeholder layer is active; no live connection is configured.',
        'configured': isConfigured,
        'url': AppConfig.supabaseUrl,
      };

  Future<List<Map<String, dynamic>>> fetch(String table,
      {Map<String, dynamic>? filters}) async {
    await Future<void>.delayed(const Duration(milliseconds: 1));
    return List<Map<String, dynamic>>.unmodifiable(
        const <Map<String, dynamic>>[]);
  }

  Future<Map<String, dynamic>> upsert(
      String table, Map<String, dynamic> item) async {
    await Future<void>.delayed(const Duration(milliseconds: 1));
    return <String, dynamic>{
      'table': table,
      'status': 'placeholder',
      'configured': isConfigured,
      'item': Map<String, dynamic>.from(item),
    };
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
