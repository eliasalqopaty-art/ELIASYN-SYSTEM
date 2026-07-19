import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/models/dashboard_summary.dart';

class DashboardSummarySection extends StatelessWidget {
  const DashboardSummarySection({
    super.key,
    required this.metrics,
  });

  final List<DashboardMetric> metrics;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 900
            ? 4
            : constraints.maxWidth > 600
                ? 2
                : 1;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: metrics
              .map((metric) => SizedBox(
                    width: (constraints.maxWidth - 16 * (columns - 1)) /
                        columns.clamp(1, 4),
                    child: _MetricCard(metric: metric),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.metric});

  final DashboardMetric metric;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(metric.color).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_iconData(metric.icon), color: Color(metric.color)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(metric.label,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(metric.value,
              style: TextStyle(
                  color: Color(metric.color),
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  IconData _iconData(String iconName) {
    switch (iconName) {
      case 'business':
        return Icons.business;
      case 'warehouse':
        return Icons.warehouse;
      case 'medication':
        return Icons.medication;
      case 'people':
        return Icons.people;
      case 'local_shipping':
        return Icons.local_shipping;
      case 'inventory':
        return Icons.inventory_2;
      default:
        return Icons.dashboard;
    }
  }
}

class DashboardAlertsSection extends StatelessWidget {
  const DashboardAlertsSection({
    super.key,
    required this.alerts,
  });

  final List<DashboardAlert> alerts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('تنبيهات النظام',
            style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth > 900
                ? 4
                : constraints.maxWidth > 600
                    ? 2
                    : 1;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: alerts
                  .map((alert) => SizedBox(
                        width: (constraints.maxWidth - 16 * (columns - 1)) /
                            columns.clamp(1, 4),
                        child: _AlertCard(alert: alert),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({required this.alert});

  final DashboardAlert alert;

  @override
  Widget build(BuildContext context) {
    final color = _alertColor(alert.level);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(alert.category,
              style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Row(
            children: [
              Text('${alert.count}',
                  style: TextStyle(
                      color: color, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(alert.level.toUpperCase(),
                    style: TextStyle(color: color, fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _alertColor(String level) {
    switch (level) {
      case 'danger':
        return AppColors.danger;
      case 'warning':
        return AppColors.warning;
      default:
        return AppColors.primary;
    }
  }
}

class DashboardHealthSection extends StatelessWidget {
  const DashboardHealthSection({
    super.key,
    required this.healthChecks,
  });

  final List<DashboardHealth> healthChecks;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('صحة النظام',
              style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...healthChecks.map((health) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(health.label,
                          style: const TextStyle(
                              color: AppColors.textSecondary, fontSize: 13)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _healthColor(health.severity).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(health.status,
                          style: TextStyle(
                              color: _healthColor(health.severity),
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 12),
          Text('تفاصيل: ${healthChecks.map((e) => e.detail).join(' · ')}',
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  Color _healthColor(String severity) {
    switch (severity) {
      case 'good':
        return AppColors.success;
      case 'warning':
        return AppColors.warning;
      case 'danger':
        return AppColors.danger;
      default:
        return AppColors.primary;
    }
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
