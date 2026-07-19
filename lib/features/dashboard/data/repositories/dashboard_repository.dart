import '../../../../core/services/supabase_service.dart';

class DashboardRepository {
  const DashboardRepository({this.supabaseService = const SupabaseService()});

  final SupabaseService supabaseService;

  Future<Map<String, dynamic>> loadSnapshot() async {
    await supabaseService.ping();
    return <String, dynamic>{
      'totalCompanies': 24,
      'totalWarehouses': 12,
      'totalMedicines': 1840,
      'totalUsers': 89,
      'totalShipments': 156,
      'alerts': <Map<String, dynamic>>[
        {'category': 'AI alerts', 'count': 5, 'level': 'info'},
        {'category': 'Inventory alerts', 'count': 23, 'level': 'warning'},
        {'category': 'Expiry alerts', 'count': 7, 'level': 'danger'},
        {'category': 'Fraud alerts', 'count': 2, 'level': 'danger'},
      ],
      'systemHealth': <Map<String, String>>[
        {
          'label': 'Supabase placeholder',
          'status': 'Available',
          'detail': 'Mock service responding',
          'severity': 'good'
        },
        {
          'label': 'API latency',
          'status': 'Stable',
          'detail': 'Mock response time within target',
          'severity': 'good'
        },
        {
          'label': 'Sync engine',
          'status': 'Healthy',
          'detail': 'No pending failures detected',
          'severity': 'good'
        },
      ],
    };
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
