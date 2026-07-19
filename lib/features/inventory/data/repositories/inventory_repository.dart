import '../../domain/models/inventory_item.dart';

class InventoryRepository {
  const InventoryRepository();

  Future<List<InventoryItem>> fetchAll() async => const <InventoryItem>[
        InventoryItem(
          id: 'inv-1',
          sku: 'SKU-001',
          barcode: '1234567890123',
          batch: 'B-001',
          expiryDate: '2026-12-31',
          packageLength: 10,
          packageWidth: 8,
          packageHeight: 5,
          packageWeight: 0.5,
          packageVolume: 0.4,
          packageColor: 'أزرق',
          packageType: 'Box',
        ),
        InventoryItem(
          id: 'inv-2',
          sku: 'SKU-002',
          barcode: '9876543210987',
          batch: 'B-002',
          expiryDate: '2025-08-12',
          packageLength: 6,
          packageWidth: 6,
          packageHeight: 18,
          packageWeight: 0.35,
          packageVolume: 0.65,
          packageColor: 'أبيض',
          packageType: 'Bottle',
        ),
        InventoryItem(
          id: 'inv-3',
          sku: 'SKU-003',
          barcode: '5647382910456',
          batch: 'B-003',
          expiryDate: '2024-12-01',
          packageLength: 4,
          packageWidth: 4,
          packageHeight: 15,
          packageWeight: 0.18,
          packageVolume: 0.24,
          packageColor: 'أخضر',
          packageType: 'Pouch',
        ),
        InventoryItem(
          id: 'inv-4',
          sku: 'SKU-004',
          barcode: '1122334455667',
          batch: 'B-004',
          expiryDate: '2027-03-15',
          packageLength: 12,
          packageWidth: 9,
          packageHeight: 3,
          packageWeight: 0.7,
          packageVolume: 0.32,
          packageColor: 'أحمر',
          packageType: 'Tube',
        ),
      ];

  Future<InventoryItem?> fetchById(String id) async {
    final items = await fetchAll();
    return items.where((item) => item.id == id).isEmpty
        ? null
        : items.where((item) => item.id == id).first;
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
