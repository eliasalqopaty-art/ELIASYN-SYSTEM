import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/repositories/dashboard_repository.dart';
import '../../data/services/dashboard_service.dart';
import '../../domain/models/dashboard_summary.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>(
  (ref) => const DashboardRepository(),
);

final dashboardServiceProvider = Provider<DashboardService>(
  (ref) => DashboardService(repository: ref.watch(dashboardRepositoryProvider)),
);

final executiveDashboardProvider = FutureProvider<ExecutiveDashboardState>(
  (ref) async {
    final service = ref.watch(dashboardServiceProvider);
    final snapshot = await service.fetchSnapshot();

    final alerts = (snapshot['alerts'] as List<dynamic>)
        .map((entry) => DashboardAlert(
              category: entry['category'] as String,
              count: entry['count'] as int,
              level: entry['level'] as String,
            ))
        .toList();

    final metrics = <DashboardMetric>[
      DashboardMetric(
        label: 'الشركات',
        value: '${snapshot['totalCompanies'] as int}',
        icon: 'business',
        color: AppColors.primary.toARGB32(),
      ),
      DashboardMetric(
        label: 'المخازن',
        value: '${snapshot['totalWarehouses'] as int}',
        icon: 'warehouse',
        color: AppColors.secondary.toARGB32(),
      ),
      DashboardMetric(
        label: 'الأدوية',
        value: '${snapshot['totalMedicines'] as int}',
        icon: 'medication',
        color: AppColors.success.toARGB32(),
      ),
      DashboardMetric(
        label: 'المستخدمون',
        value: '${snapshot['totalUsers'] as int}',
        icon: 'people',
        color: AppColors.warning.toARGB32(),
      ),
      DashboardMetric(
        label: 'الشحنات',
        value: '${snapshot['totalShipments'] as int}',
        icon: 'local_shipping',
        color: AppColors.danger.toARGB32(),
      ),
    ];

    final healthChecks = (snapshot['systemHealth'] as List<dynamic>)
        .map((entry) => DashboardHealth(
              label: entry['label'] as String,
              status: entry['status'] as String,
              detail: entry['detail'] as String,
              severity: entry['severity'] as String,
            ))
        .toList();

    return ExecutiveDashboardState(
      totalCompanies: snapshot['totalCompanies'] as int,
      totalWarehouses: snapshot['totalWarehouses'] as int,
      totalMedicines: snapshot['totalMedicines'] as int,
      totalUsers: snapshot['totalUsers'] as int,
      totalShipments: snapshot['totalShipments'] as int,
      alerts: alerts,
      metrics: metrics,
      healthChecks: healthChecks,
    );
  },
);
