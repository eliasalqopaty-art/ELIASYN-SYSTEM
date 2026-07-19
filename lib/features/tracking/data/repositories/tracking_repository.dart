class TrackingRepository {
  const TrackingRepository();

  Future<List<Map<String, dynamic>>> fetchAll() async =>
      const <Map<String, dynamic>>[
        {
          'id': 'shp-1',
          'shipmentId': 'SHIP-001',
          'status': 'In Transit',
          'source': 'صنعاء',
          'destination': 'عدن',
          'lastUpdate': 'قبل 12 دقيقة',
          'currentHolder': 'مخزن الجنوب',
          'timeline': [
            'تم استلام الشحنة',
            'في الطريق إلى الميناء',
            'تم تسليمها إلى الناقل'
          ],
          'liveStatus': 'تتبع مباشر: تحديثات قيد التشغيل',
        },
        {
          'id': 'shp-2',
          'shipmentId': 'SHIP-002',
          'status': 'Delivered',
          'source': 'المخزن المركزي',
          'destination': 'تعز',
          'lastUpdate': 'قبل 1 ساعة',
          'currentHolder': 'مدير التوزيع',
          'timeline': [
            'تم شحن الشحنة',
            'تم الوصول إلى مركز التوزيع',
            'تم التسليم للمستودع'
          ],
          'liveStatus': 'تتبع مباشر: التحديث الأخير متاح',
        },
        {
          'id': 'shp-3',
          'shipmentId': 'SHIP-003',
          'status': 'Pending',
          'source': 'صنعاء',
          'destination': 'إب',
          'lastUpdate': 'قبل 5 دقائق',
          'currentHolder': 'مندوب التوصيل',
          'timeline': [
            'تم إنشاء الطلب',
            'بانتظار التحويل إلى النقل',
            'في انتظار تأكيد الاستلام'
          ],
          'liveStatus': 'تتبع مباشر: في انتظار تحديث جديد',
        },
      ];

  Future<Map<String, dynamic>> fetchById(String id) async {
    final items = await fetchAll();
    return items.firstWhere(
      (item) => item['id'] == id,
      orElse: () => {
        'id': id,
        'shipmentId': 'SHIP-UNK',
        'status': 'Unknown',
        'source': 'Unknown',
        'destination': 'Unknown',
        'lastUpdate': 'Unknown',
        'currentHolder': 'Unknown',
        'timeline': const <String>[],
        'liveStatus': 'Live tracking placeholder',
      },
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
