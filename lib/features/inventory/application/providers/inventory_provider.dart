import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/inventory_repository.dart';
import '../../data/services/fraud_detection_service.dart';
import '../../data/services/inventory_service.dart';

final inventoryRepositoryProvider = Provider<InventoryRepository>(
  (ref) => const InventoryRepository(),
);

final inventoryServiceProvider = Provider<InventoryService>(
  (ref) => InventoryService(repository: ref.watch(inventoryRepositoryProvider)),
);

final inventoryItemsProvider =
    FutureProvider((ref) => ref.watch(inventoryServiceProvider).load());

final fraudDetectionServiceProvider = Provider<FraudDetectionService>(
  (ref) => const FraudDetectionService(),
);
