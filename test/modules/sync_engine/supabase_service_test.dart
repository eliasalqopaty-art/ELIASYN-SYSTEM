import 'package:alasim_management/core/services/supabase_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SupabaseService placeholder layer', () {
    late SupabaseService service;

    setUp(() {
      service = const SupabaseService();
    });

    test('ping reports placeholder mode without live connection', () async {
      final result = await service.ping();

      expect(result['status'], 'placeholder');
      expect(result['message'], contains('placeholder'));
      expect(result['configured'], isFalse);
    });

    test('fetch and upsert stay non-destructive placeholder operations',
        () async {
      final rows = await service.fetch('profiles');
      final inserted = await service.upsert('profiles', {'id': 'demo'});

      expect(rows, isEmpty);
      expect(inserted['table'], 'profiles');
      expect(inserted['status'], 'placeholder');
    });
  });
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
