import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/app_notification.dart';

final notificationsBoxProvider =
    Provider<Box<Map>>((ref) => Hive.box<Map>('notifications'));

final notificationsControllerProvider =
    StateNotifierProvider<NotificationsController, List<AppNotification>>(
        (ref) {
  return NotificationsController(ref)..load();
});

final unreadNotificationsCountProvider = Provider<int>((ref) {
  return ref.watch(notificationsControllerProvider).where((item) {
    return !item.isRead;
  }).length;
});

class NotificationsController extends StateNotifier<List<AppNotification>> {
  final Ref ref;
  final _uuid = const Uuid();

  NotificationsController(this.ref) : super(const []);

  Future<void> load() async {
    final box = ref.read(notificationsBoxProvider);
    if (box.isEmpty) await _seed();

    final notifications = box.values
        .map((value) =>
            AppNotification.fromMap(Map<String, dynamic>.from(value)))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    state = notifications;
  }

  Future<void> push({
    required String title,
    required String message,
    String type = 'info',
  }) async {
    final notification = AppNotification(
      id: _uuid.v4(),
      title: title,
      message: message,
      type: type,
      isRead: false,
      createdAt: DateTime.now(),
    );
    await ref
        .read(notificationsBoxProvider)
        .put(notification.id, notification.toMap());
    await load();
  }

  Future<void> markRead(String id) async {
    final notification = state.where((item) => item.id == id).firstOrNull;
    if (notification == null) return;
    final updated = notification.copyWith(isRead: true);
    await ref.read(notificationsBoxProvider).put(updated.id, updated.toMap());
    await load();
  }

  Future<void> markAllRead() async {
    final box = ref.read(notificationsBoxProvider);
    for (final notification in state) {
      await box.put(
        notification.id,
        notification.copyWith(isRead: true).toMap(),
      );
    }
    await load();
  }

  Future<void> _seed() async {
    final now = DateTime.now();
    final samples = [
      AppNotification(
        id: 'stock-low',
        title: 'نقص مخزون',
        message: 'أموكسيسيلين 250mg وصل إلى حد الطلب.',
        type: 'warning',
        isRead: false,
        createdAt: now.subtract(const Duration(minutes: 15)),
      ),
      AppNotification(
        id: 'sync-ready',
        title: 'المزامنة جاهزة',
        message: 'تم تجهيز طابور المزامنة للعمل دون اتصال.',
        type: 'info',
        isRead: false,
        createdAt: now.subtract(const Duration(hours: 1)),
      ),
    ];

    final box = ref.read(notificationsBoxProvider);
    for (final notification in samples) {
      await box.put(notification.id, notification.toMap());
    }
  }
}
