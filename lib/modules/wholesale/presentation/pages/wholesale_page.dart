import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/records_page.dart';

class WholesalePage extends StatelessWidget {
  const WholesalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RecordsPage(
      title: 'محلات الجملة',
      searchHint: 'بحث في محلات الجملة...',
      addLabel: 'إضافة محل جملة',
      icon: Icons.storefront,
      initialRecords: [
        RecordDefinition(
          title: 'جملة المدينة للأدوية',
          icon: Icons.storefront,
          owner: 'عبدالله ناصر',
          location: 'صنعاء - باب اليمن',
          phone: '777 552 404',
          status: 'نشط',
          metricLabel: 'فواتير',
          metricValue: '29',
          color: AppColors.primary,
          tags: ['كميات كبيرة'],
        ),
        RecordDefinition(
          title: 'مركز الأمانة الطبي',
          icon: Icons.storefront,
          owner: 'فؤاد الأشول',
          location: 'إب - الظهار',
          phone: '770 118 701',
          status: 'مراجعة',
          metricLabel: 'فواتير',
          metricValue: '11',
          color: AppColors.warning,
          tags: ['مديونية'],
        ),
        RecordDefinition(
          title: 'حضرموت فارما',
          icon: Icons.storefront,
          owner: 'سالم باوزير',
          location: 'المكلا',
          phone: '733 441 200',
          status: 'نشط',
          metricLabel: 'فواتير',
          metricValue: '17',
          color: AppColors.success,
          tags: ['توريد بحري'],
        ),
      ],
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
