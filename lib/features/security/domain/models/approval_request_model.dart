class ApprovalRequestModel {
  const ApprovalRequestModel({
    required this.id,
    required this.operation,
    required this.description,
    required this.requester,
    required this.status,
    required this.createdAt,
    this.requiresBiometric = true,
  });

  final String id;
  final String operation;
  final String description;
  final String requester;
  final String status;
  final String createdAt;
  final bool requiresBiometric;

  ApprovalRequestModel copyWith({
    String? id,
    String? operation,
    String? description,
    String? requester,
    String? status,
    String? createdAt,
    bool? requiresBiometric,
  }) {
    return ApprovalRequestModel(
      id: id ?? this.id,
      operation: operation ?? this.operation,
      description: description ?? this.description,
      requester: requester ?? this.requester,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      requiresBiometric: requiresBiometric ?? this.requiresBiometric,
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
