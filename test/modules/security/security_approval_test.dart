import 'package:alasim_management/features/security/data/services/security_service.dart';
import 'package:alasim_management/features/security/domain/models/approval_request_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ApprovalRequestModel stores protected operation metadata', () {
    const request = ApprovalRequestModel(
      id: 'APR-1001',
      operation: 'Inventory Destruction',
      description: 'تدمير 12 عبوة',
      requester: 'سلمى',
      status: 'Pending',
      createdAt: '2026-06-02 10:30',
    );

    expect(request.operation, 'Inventory Destruction');
    expect(request.requiresBiometric, isTrue);
    expect(request.status, 'Pending');
  });

  test('SecurityService returns approval history for a protected operation',
      () async {
    const service = SecurityService();

    final history = await service.loadHistory('Inventory Transfer');

    expect(history, isNotEmpty);
    expect(history.first.operation, 'Inventory Transfer');
  });

  test('SecurityService approves a request in mock flow', () async {
    const service = SecurityService();

    final approved = await service.approve('APR-1001');

    expect(approved.id, 'APR-1001');
    expect(approved.status, 'Approved');
  });
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
