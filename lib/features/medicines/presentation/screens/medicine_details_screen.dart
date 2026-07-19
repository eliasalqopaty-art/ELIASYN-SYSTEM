import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../application/providers/medicines_provider.dart';

class MedicineDetailsScreen extends ConsumerWidget {
  final String medicineId;

  const MedicineDetailsScreen({super.key, required this.medicineId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(medicineDetailsProvider(medicineId));

    return Directionality(
      textDirection: TextDirection.rtl,
      child: state.when(
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          appBar: AppBar(title: const Text('تفاصيل الدواء')),
          body: Center(
            child: Text(
              'فشل تحميل تفاصيل الدواء: $error',
              style: const TextStyle(color: AppColors.danger),
            ),
          ),
        ),
        data: (medicine) => Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.surface,
            title: Text(medicine.tradeName),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailRow(label: 'الاسم التجاري', value: medicine.tradeName),
                  _DetailRow(
                      label: 'الاسم العلمي', value: medicine.genericName),
                  _DetailRow(label: 'المصنع', value: medicine.manufacturer),
                  _DetailRow(label: 'شكل الجرعة', value: medicine.dosageForm),
                  _DetailRow(label: 'التركيز', value: medicine.strength),
                  _DetailRow(label: 'رقم الباتش', value: medicine.batchNumber),
                  _DetailRow(label: 'رقم اللوت', value: medicine.lotNumber),
                  _DetailRow(
                      label: 'تاريخ انتهاء الصلاحية',
                      value: medicine.expiryDate),
                  const SizedBox(height: 20),
                  const Text(
                    'معلومات إضافية',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'يمكنك استخدام هذه الصفحة لمراجعة البيانات التفصيلية للدواء ومتابعة صلاحية الدفعات.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
