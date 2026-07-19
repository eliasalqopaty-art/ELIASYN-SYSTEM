import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/records_page.dart';

class PharmaciesPage extends StatelessWidget {
  const PharmaciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RecordsPage(
      title: 'الصيدليات',
      searchHint: 'بحث في الصيدليات...',
      addLabel: 'إضافة صيدلية',
      icon: Icons.local_pharmacy,
      initialRecords: [
        RecordDefinition(
          title: 'صيدلية الياسمين',
          icon: Icons.local_pharmacy,
          owner: 'د. أحمد صالح',
          location: 'صنعاء - شارع الستين',
          phone: '777 120 450',
          status: 'نشط',
          metricLabel: 'طلبات',
          metricValue: '42',
          color: AppColors.primary,
          tags: ['ذهبي', 'دفع آجل'],
        ),
        RecordDefinition(
          title: 'صيدلية الشفاء',
          icon: Icons.local_pharmacy,
          owner: 'د. منى الحداد',
          location: 'تعز - الحوبان',
          phone: '733 882 119',
          status: 'نشط',
          metricLabel: 'طلبات',
          metricValue: '31',
          color: AppColors.success,
          tags: ['توريد أسبوعي'],
        ),
        RecordDefinition(
          title: 'صيدلية الحياة',
          icon: Icons.local_pharmacy,
          owner: 'بشير القباطي',
          location: 'إب - شارع العدين',
          phone: '770 223 910',
          status: 'مراجعة',
          metricLabel: 'طلبات',
          metricValue: '12',
          color: AppColors.warning,
          tags: ['حد ائتماني'],
        ),
      ],
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
