import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/records_page.dart';

class DistributorsPage extends StatelessWidget {
  const DistributorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RecordsPage(
      title: 'الموزعون',
      searchHint: 'بحث في الموزعين...',
      addLabel: 'إضافة موزع',
      icon: Icons.local_shipping,
      initialRecords: [
        RecordDefinition(
          title: 'النور للتوزيع',
          icon: Icons.local_shipping,
          owner: 'مازن السنحاني',
          location: 'صنعاء',
          phone: '777 330 001',
          status: 'نشط',
          metricLabel: 'شحنات',
          metricValue: '64',
          color: AppColors.primary,
          tags: ['تبريد', 'داخل المدينة'],
        ),
        RecordDefinition(
          title: 'الشرق اللوجستي',
          icon: Icons.local_shipping,
          owner: 'رامي القديمي',
          location: 'مأرب',
          phone: '735 770 801',
          status: 'مراجعة',
          metricLabel: 'شحنات',
          metricValue: '21',
          color: AppColors.warning,
          tags: ['خط طويل'],
        ),
        RecordDefinition(
          title: 'عدن فارما للنقل',
          icon: Icons.local_shipping,
          owner: 'علي باشا',
          location: 'عدن',
          phone: '733 001 554',
          status: 'نشط',
          metricLabel: 'شحنات',
          metricValue: '38',
          color: AppColors.success,
          tags: ['موانئ', 'تسليم سريع'],
        ),
      ],
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
