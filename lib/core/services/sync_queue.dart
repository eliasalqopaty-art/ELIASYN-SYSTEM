class SyncQueueItem {
  const SyncQueueItem(
      {required this.id, required this.resource, required this.payload});

  final String id;
  final String resource;
  final Map<String, dynamic> payload;
}

class SyncQueue {
  const SyncQueue();

  Future<List<SyncQueueItem>> load() async => const <SyncQueueItem>[];
  Future<void> add(SyncQueueItem item) async {}
  Future<void> remove(String id) async {}
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
