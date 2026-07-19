import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/records_page.dart';

class RepresentativesPage extends StatelessWidget {
  const RepresentativesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RecordsPage(
      title: 'المندوبون',
      searchHint: 'بحث في المندوبين...',
      addLabel: 'إضافة مندوب',
      icon: Icons.person_pin,
      initialRecords: [
        RecordDefinition(
          title: 'أحمد محمد',
          icon: Icons.person_pin,
          owner: 'مسار صنعاء الشمالي',
          location: 'صنعاء',
          phone: '777 014 550',
          status: 'نشط',
          metricLabel: 'زيارات',
          metricValue: '18',
          color: AppColors.success,
          tags: ['تحصيل', 'صيدليات'],
        ),
        RecordDefinition(
          title: 'خالد علي',
          icon: Icons.person_pin,
          owner: 'مسار تعز',
          location: 'تعز',
          phone: '733 906 441',
          status: 'نشط',
          metricLabel: 'زيارات',
          metricValue: '14',
          color: AppColors.primary,
          tags: ['طلبات جديدة'],
        ),
        RecordDefinition(
          title: 'محمد سالم',
          icon: Icons.person_pin,
          owner: 'مسار إب',
          location: 'إب',
          phone: '770 102 090',
          status: 'في زيارة',
          metricLabel: 'زيارات',
          metricValue: '9',
          color: AppColors.warning,
          tags: ['متابعة ميدانية'],
        ),
      ],
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
