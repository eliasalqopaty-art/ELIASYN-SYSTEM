import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../application/providers/security_provider.dart';

class SecurityApprovalFlow extends ConsumerWidget {
  const SecurityApprovalFlow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsState = ref.watch(securityRequestsProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: requestsState.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stack) => Scaffold(
          appBar: AppBar(title: const AppLogo(showSubtitle: false)),
          body: Center(
              child: Text('فشل تحميل الطلبات: $error',
                  style: const TextStyle(color: AppColors.danger))),
        ),
        data: (requests) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(title: const AppLogo(showSubtitle: false)),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('العمليات المحمية',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  const Wrap(spacing: 10, runSpacing: 10, children: [
                    _ProtectedChip(label: 'Inventory Destruction'),
                    _ProtectedChip(label: 'Inventory Transfer'),
                    _ProtectedChip(label: 'Inventory Approval'),
                    _ProtectedChip(label: 'Shipment Approval'),
                  ]),
                  const SizedBox(height: 18),
                  const AppWatermark(),
                  Expanded(
                    child: ListView.separated(
                      itemCount: requests.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final request = requests[index];
                        return Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.border)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(request.operation,
                                          style: const TextStyle(
                                              color: AppColors.textPrimary,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4),
                                      Text(request.description,
                                          style: const TextStyle(
                                              color: AppColors.textSecondary)),
                                      const SizedBox(height: 6),
                                      Text(
                                          'الطلب: ${request.requester} • ${request.createdAt}',
                                          style: const TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 12)),
                                    ]),
                              ),
                              _StatusBadge(status: request.status),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProtectedChip extends StatelessWidget {
  final String label;
  const _ProtectedChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      avatar: const Icon(Icons.lock, size: 16),
      backgroundColor: AppColors.primary.withValues(alpha: 0.12),
      labelStyle: const TextStyle(color: AppColors.primary),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      'Approved' => AppColors.success,
      'Rejected' => AppColors.danger,
      _ => AppColors.warning,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(14)),
      child: Text(status,
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}
