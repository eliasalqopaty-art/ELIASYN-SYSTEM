import 'package:alasim_management/core/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../features/dashboard/application/providers/dashboard_provider.dart';
import '../../../../features/dashboard/presentation/widgets/dashboard_widgets.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(executiveDashboardProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const AppLogo(showSubtitle: false),
        actions: [
          IconButton(
              icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          const CircleAvatar(
            backgroundColor: AppColors.primary,
            radius: 16,
            child:
                Text('م', style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: dashboard.when(
        data: (state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('مرحبا نظام الياسين',
                    style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('لوحة التحكم الرئيسية - نظام إدارة الأدوية',
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 14)),
                const SizedBox(height: 28),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 1100;
                    return isWide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: DashboardSummarySection(
                                  metrics: state.metrics,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 2,
                                child: DashboardHealthSection(
                                    healthChecks: state.healthChecks),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              DashboardSummarySection(metrics: state.metrics),
                              const SizedBox(height: 20),
                              DashboardHealthSection(
                                  healthChecks: state.healthChecks),
                            ],
                          );
                  },
                ),
                const SizedBox(height: 28),
                DashboardAlertsSection(alerts: state.alerts),
                const AppWatermark(),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('تعذر تحميل لوحة التحكم: $error')),
      ),
    );
  }
}
