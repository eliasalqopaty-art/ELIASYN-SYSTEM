import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../application/providers/medicines_provider.dart';
import '../../domain/models/medicines_model.dart';
import 'medicine_details_screen.dart';

class MedicinesScreen extends ConsumerStatefulWidget {
  const MedicinesScreen({super.key});

  @override
  ConsumerState<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends ConsumerState<MedicinesScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  List<MedicinesModel> _filterMedicines(List<MedicinesModel> medicines) {
    final normalized = _query.trim().toLowerCase();
    if (normalized.isEmpty) return medicines;
    return medicines.where((medicine) {
      return medicine.tradeName.toLowerCase().contains(normalized) ||
          medicine.genericName.toLowerCase().contains(normalized) ||
          medicine.manufacturer.toLowerCase().contains(normalized) ||
          medicine.batchNumber.toLowerCase().contains(normalized);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medicineState = ref.watch(medicinesListProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: medicineState.when(
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          appBar: AppBar(title: const Text('الأدوية')),
          body: Center(
            child: Text(
              'فشل تحميل قائمة الأدوية: $error',
              style: const TextStyle(color: AppColors.danger),
            ),
          ),
        ),
        data: (medicines) {
          final filtered = _filterMedicines(medicines);

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.surface,
              title: const Text('قائمة الأدوية'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _query = value),
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'ابحث باسم تجاري، عام، الشركة أو الباتش',
                      hintStyle:
                          const TextStyle(color: AppColors.textSecondary),
                      prefixIcon: const Icon(Icons.search,
                          color: AppColors.textSecondary),
                      filled: true,
                      fillColor: AppColors.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'الأدوية (${filtered.length})',
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Divider(color: AppColors.border, height: 1),
                          Expanded(
                            child: filtered.isEmpty
                                ? const Center(
                                    child: Text(
                                      'لا توجد أدوية مطابقة',
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  )
                                : ListView.separated(
                                    itemCount: filtered.length,
                                    separatorBuilder: (_, __) => const Divider(
                                      color: AppColors.border,
                                      height: 1,
                                    ),
                                    itemBuilder: (context, index) {
                                      final medicine = filtered[index];
                                      return _MedicineRow(
                                        medicine: medicine,
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  MedicineDetailsScreen(
                                                medicineId: medicine.id,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
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

class _MedicineRow extends StatelessWidget {
  final MedicinesModel medicine;
  final VoidCallback onTap;

  const _MedicineRow({
    required this.medicine,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withValues(alpha: 0.16),
        child: const Icon(Icons.medical_services, color: AppColors.primary),
      ),
      title: Text(
        medicine.tradeName,
        style: const TextStyle(color: AppColors.textPrimary),
      ),
      subtitle: Text(
        '${medicine.genericName} • ${medicine.manufacturer}',
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            medicine.dosageForm,
            style: const TextStyle(color: AppColors.success),
          ),
          const SizedBox(height: 4),
          Text(
            'انتهاء: ${medicine.expiryDate}',
            style:
                const TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
