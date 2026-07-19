import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/audit_event.dart';

final auditBoxProvider = Provider<Box<Map>>((ref) => Hive.box<Map>('audit'));

final auditControllerProvider =
    StateNotifierProvider<AuditController, List<AuditEvent>>((ref) {
  return AuditController(ref)..load();
});

class AuditController extends StateNotifier<List<AuditEvent>> {
  final Ref ref;
  final _uuid = const Uuid();

  AuditController(this.ref) : super(const []);

  Future<void> load() async {
    final box = ref.read(auditBoxProvider);
    final events = box.values.map(_fromStoredMap).toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    state = events;
  }

  Future<void> log({
    required String actor,
    required String action,
    required String target,
    Map<String, dynamic>? metadata,
  }) async {
    final event = AuditEvent(
      id: _uuid.v4(),
      actor: actor,
      action: action,
      target: target,
      metadata: metadata,
      timestamp: DateTime.now(),
    );
    await ref.read(auditBoxProvider).put(event.id, event.toMap());
    await load();
  }

  Future<void> clear() async {
    await ref.read(auditBoxProvider).clear();
    state = const [];
  }

  AuditEvent _fromStoredMap(Map value) {
    return AuditEvent.fromMap(Map<String, dynamic>.from(value));
  }
}
