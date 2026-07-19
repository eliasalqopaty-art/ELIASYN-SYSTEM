import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/sync_task.dart';

final syncQueueBoxProvider =
    Provider<Box<Map>>((ref) => Hive.box<Map>('sync_queue'));

final syncEngineControllerProvider =
    StateNotifierProvider<SyncEngineController, List<SyncTask>>((ref) {
  return SyncEngineController(ref)..load();
});

class SyncEngineController extends StateNotifier<List<SyncTask>> {
  final Ref ref;
  final _uuid = const Uuid();

  SyncEngineController(this.ref) : super(const []);

  Future<void> load() async {
    final tasks = ref
        .read(syncQueueBoxProvider)
        .values
        .map((value) => SyncTask.fromMap(Map<String, dynamic>.from(value)))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    state = tasks;
  }

  Future<void> enqueue({
    required String entity,
    required String action,
    required Map<String, dynamic> payload,
  }) async {
    final task = SyncTask(
      id: _uuid.v4(),
      entity: entity,
      action: action,
      payload: payload,
      status: 'pending',
      createdAt: DateTime.now(),
    );
    await ref.read(syncQueueBoxProvider).put(task.id, task.toMap());
    await load();
  }

  Future<void> markSynced(String taskId) async {
    final task = state.where((item) => item.id == taskId).firstOrNull;
    if (task == null) return;
    final updated = task.copyWith(status: 'synced', syncedAt: DateTime.now());
    await ref.read(syncQueueBoxProvider).put(updated.id, updated.toMap());
    await load();
  }

  Future<void> clearSynced() async {
    final box = ref.read(syncQueueBoxProvider);
    for (final task in state.where((item) => item.status == 'synced')) {
      await box.delete(task.id);
    }
    await load();
  }
}
