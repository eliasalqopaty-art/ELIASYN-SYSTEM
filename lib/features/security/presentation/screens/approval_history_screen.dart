import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../application/providers/security_provider.dart';

class ApprovalHistoryScreen extends ConsumerWidget {
  const ApprovalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsState = ref.watch(securityRequestsProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: requestsState.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stack) => Scaffold(
            appBar: AppBar(title: const Text('Approval History')),
            body: Center(
                child: Text('فشل تحميل السجل: $error',
                    style: const TextStyle(color: AppColors.danger)))),
        data: (requests) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(title: const Text('Approval History')),
            body: Padding(
              padding: const EdgeInsets.all(20),
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(request.operation,
                              style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('المستخدم: ${request.requester}',
                              style: const TextStyle(
                                  color: AppColors.textSecondary)),
                          const SizedBox(height: 4),
                          Text('الحالة: ${request.status}',
                              style: TextStyle(
                                  color: request.status == 'Approved'
                                      ? AppColors.success
                                      : request.status == 'Rejected'
                                          ? AppColors.danger
                                          : AppColors.warning,
                                  fontWeight: FontWeight.bold)),
                        ]),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
