class AuditEvent {
  final String id;
  final String actor;
  final String action;
  final String target;
  final Map<String, dynamic>? metadata;
  final DateTime timestamp;

  AuditEvent({
    required this.id,
    required this.actor,
    required this.action,
    required this.target,
    this.metadata,
    required this.timestamp,
  });

  factory AuditEvent.fromMap(Map<String, dynamic> map) {
    return AuditEvent(
      id: map['id'] as String,
      actor: map['actor'] as String? ?? 'system',
      action: map['action'] as String? ?? 'action',
      target: map['target'] as String? ?? '',
      metadata: map['metadata'] == null
          ? null
          : Map<String, dynamic>.from(map['metadata'] as Map),
      timestamp: DateTime.tryParse(map['timestamp'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'actor': actor,
      'action': action,
      'target': target,
      'metadata': metadata,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
