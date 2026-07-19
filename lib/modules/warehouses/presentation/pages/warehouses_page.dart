import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/records_page.dart';

class WarehousesPage extends StatelessWidget {
  const WarehousesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RecordsPage(
      title: 'المخازن',
      searchHint: 'بحث في المخازن...',
      addLabel: 'إضافة مخزن',
      icon: Icons.warehouse,
      initialRecords: [
        RecordDefinition(
          title: 'المخزن المركزي',
          icon: Icons.warehouse,
          owner: 'فهد العنسي',
          location: 'صنعاء - منطقة ذهبان',
          phone: '771 220 600',
          status: 'نشط',
          metricLabel: 'أصناف',
          metricValue: '1,248',
          color: AppColors.primary,
          tags: ['تبريد', 'صرف مباشر'],
        ),
        RecordDefinition(
          title: 'مخزن الجنوب',
          icon: Icons.warehouse,
          owner: 'نادر الشيباني',
          location: 'عدن - المنصورة',
          phone: '735 441 009',
          status: 'نشط',
          metricLabel: 'أصناف',
          metricValue: '684',
          color: AppColors.success,
          tags: ['شحن يومي'],
        ),
        RecordDefinition(
          title: 'مخزن المرتجعات',
          icon: Icons.warehouse,
          owner: 'سامي المطري',
          location: 'صنعاء - جولة آية',
          phone: '777 991 330',
          status: 'مراجعة',
          metricLabel: 'أصناف',
          metricValue: '96',
          color: AppColors.warning,
          tags: ['جرد مفتوح'],
        ),
      ],
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
