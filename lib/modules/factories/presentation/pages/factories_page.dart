import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/records_page.dart';

class FactoriesPage extends StatelessWidget {
  const FactoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RecordsPage(
      title: 'المصانع',
      searchHint: 'بحث في المصانع...',
      addLabel: 'إضافة مصنع',
      icon: Icons.factory,
      initialRecords: [
        RecordDefinition(
          title: 'مصنع سبأ الدوائي',
          icon: Icons.factory,
          owner: 'قسم التوريد',
          location: 'صنعاء',
          phone: '01 445 900',
          status: 'نشط',
          metricLabel: 'عقود',
          metricValue: '8',
          color: AppColors.primary,
          tags: ['محلي', 'أولوية'],
        ),
        RecordDefinition(
          title: 'الشركة الوطنية للأدوية',
          icon: Icons.factory,
          owner: 'مكتب المبيعات',
          location: 'عدن',
          phone: '02 391 011',
          status: 'نشط',
          metricLabel: 'عقود',
          metricValue: '5',
          color: AppColors.success,
          tags: ['توريد شهري'],
        ),
        RecordDefinition(
          title: 'المعامل المتحدة',
          icon: Icons.factory,
          owner: 'إدارة الجودة',
          location: 'تعز',
          phone: '04 218 700',
          status: 'متوقف',
          metricLabel: 'عقود',
          metricValue: '2',
          color: AppColors.danger,
          tags: ['بانتظار اعتماد'],
        ),
      ],
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
