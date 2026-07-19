import 'package:alasim_management/modules/sync_engine/domain/entities/sync_task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('SyncTask preserves payload and synced state', () {
    final task = SyncTask(
      id: 'task-1',
      entity: 'pharmacy',
      action: 'create',
      payload: const {'name': 'صيدلية الاختبار'},
      status: 'pending',
      createdAt: DateTime.utc(2026, 6, 1),
    );

    final restored = SyncTask.fromMap(task.toMap());
    final synced = restored.copyWith(
      status: 'synced',
      syncedAt: DateTime.utc(2026, 6, 1, 1),
    );

    expect(restored.payload['name'], 'صيدلية الاختبار');
    expect(synced.status, 'synced');
    expect(synced.syncedAt, DateTime.utc(2026, 6, 1, 1));
  });
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
