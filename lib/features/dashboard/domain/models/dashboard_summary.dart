class DashboardMetric {
  const DashboardMetric({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final String icon;
  final int color;
}

class DashboardAlert {
  const DashboardAlert({
    required this.category,
    required this.count,
    required this.level,
  });

  final String category;
  final int count;
  final String level;
}

class DashboardHealth {
  const DashboardHealth({
    required this.label,
    required this.status,
    required this.detail,
    required this.severity,
  });

  final String label;
  final String status;
  final String detail;
  final String severity;
}

class ExecutiveDashboardState {
  const ExecutiveDashboardState({
    required this.totalCompanies,
    required this.totalWarehouses,
    required this.totalMedicines,
    required this.totalUsers,
    required this.totalShipments,
    required this.alerts,
    required this.metrics,
    required this.healthChecks,
  });

  final int totalCompanies;
  final int totalWarehouses;
  final int totalMedicines;
  final int totalUsers;
  final int totalShipments;
  final List<DashboardAlert> alerts;
  final List<DashboardMetric> metrics;
  final List<DashboardHealth> healthChecks;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
