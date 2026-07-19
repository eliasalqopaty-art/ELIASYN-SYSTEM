import 'package:alasim_management/modules/notifications/domain/entities/app_notification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppNotification can be marked as read', () {
    final notification = AppNotification(
      id: 'n1',
      title: 'تنبيه',
      message: 'رسالة اختبار',
      type: 'info',
      isRead: false,
      createdAt: DateTime.utc(2026, 6, 1),
    );

    final read = AppNotification.fromMap(notification.toMap()).copyWith(
      isRead: true,
    );

    expect(read.isRead, isTrue);
    expect(read.title, 'تنبيه');
  });
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
