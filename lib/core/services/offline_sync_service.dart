class OfflineSyncService {
  const OfflineSyncService();

  Future<void> syncPending() async {}
  Future<bool> isOnline() async => true;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
