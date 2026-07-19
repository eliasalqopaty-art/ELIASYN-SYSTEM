import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../application/providers/audit_controller.dart';

class AuditPage extends ConsumerWidget {
  const AuditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(auditControllerProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          title: const Text('سجل المراجعة'),
          actions: [
            IconButton(
              tooltip: 'تحديث',
              onPressed: () =>
                  ref.read(auditControllerProvider.notifier).load(),
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              tooltip: 'مسح السجل',
              onPressed: () =>
                  ref.read(auditControllerProvider.notifier).clear(),
              icon: const Icon(Icons.delete_outline),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: events.isEmpty
                ? const Center(
                    child: Text(
                      'لا توجد أحداث حتى الآن',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.separated(
                    itemCount: events.length,
                    separatorBuilder: (_, __) =>
                        const Divider(color: AppColors.border, height: 1),
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return ListTile(
                        leading: const Icon(
                          Icons.history,
                          color: AppColors.primary,
                        ),
                        title: Text(
                          '${event.action} - ${event.target}',
                          style: const TextStyle(color: AppColors.textPrimary),
                        ),
                        subtitle: Text(
                          '${event.actor} • ${event.timestamp.toLocal()}',
                          style:
                              const TextStyle(color: AppColors.textSecondary),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
