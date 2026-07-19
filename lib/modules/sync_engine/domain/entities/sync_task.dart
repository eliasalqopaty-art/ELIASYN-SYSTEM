class SyncTask {
  final String id;
  final String entity;
  final String action;
  final Map<String, dynamic> payload;
  final String status;
  final DateTime createdAt;
  final DateTime? syncedAt;

  const SyncTask({
    required this.id,
    required this.entity,
    required this.action,
    required this.payload,
    required this.status,
    required this.createdAt,
    this.syncedAt,
  });

  factory SyncTask.fromMap(Map<String, dynamic> map) {
    return SyncTask(
      id: map['id'] as String,
      entity: map['entity'] as String,
      action: map['action'] as String,
      payload: Map<String, dynamic>.from(map['payload'] as Map? ?? const {}),
      status: map['status'] as String? ?? 'pending',
      createdAt: DateTime.parse(map['createdAt'] as String),
      syncedAt: map['syncedAt'] == null
          ? null
          : DateTime.tryParse(map['syncedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'entity': entity,
      'action': action,
      'payload': payload,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'syncedAt': syncedAt?.toIso8601String(),
    };
  }

  SyncTask copyWith({String? status, DateTime? syncedAt}) {
    return SyncTask(
      id: id,
      entity: entity,
      action: action,
      payload: payload,
      status: status ?? this.status,
      createdAt: createdAt,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
