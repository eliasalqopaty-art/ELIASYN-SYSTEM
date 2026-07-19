import '../../domain/models/approval_request_model.dart';

class SecurityRepository {
  const SecurityRepository();

  Future<List<ApprovalRequestModel>> fetchRequests() async {
    return const [
      ApprovalRequestModel(
        id: 'APR-1001',
        operation: 'Inventory Destruction',
        description: 'تدمير 12 عبوة من lote-01 بعد انتهاء الصلاحية',
        requester: 'سلمى الحربي',
        status: 'Pending',
        createdAt: '2026-06-02 10:30',
      ),
      ApprovalRequestModel(
        id: 'APR-1002',
        operation: 'Inventory Transfer',
        description: 'نقل 25 علبة إلى مستودع الرياض',
        requester: 'عبدالله النجار',
        status: 'Approved',
        createdAt: '2026-06-02 13:15',
      ),
      ApprovalRequestModel(
        id: 'APR-1003',
        operation: 'Inventory Approval',
        description: 'اعتماد تسوية المخزون لدفعة 2026-05',
        requester: 'نور الهادي',
        status: 'Pending',
        createdAt: '2026-06-03 08:10',
      ),
      ApprovalRequestModel(
        id: 'APR-1004',
        operation: 'Shipment Approval',
        description: 'إعتماد شحنة التوزيع إلى جدة',
        requester: 'سامي الزهراني',
        status: 'Rejected',
        createdAt: '2026-06-03 09:45',
      ),
    ];
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
