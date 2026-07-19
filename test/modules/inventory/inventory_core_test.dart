import 'package:alasim_management/features/inventory/data/services/fraud_detection_service.dart';
import 'package:alasim_management/features/inventory/domain/models/inventory_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('InventoryItem supports batch expiry and package metadata', () {
    const item = InventoryItem(
      id: 'item-1',
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
    );

    expect(item.batch, 'B-001');
    expect(item.expiryDate, '2026-12-31');
    expect(item.packageVolume, 0.4);
  });

  test('FraudDetectionService flags duplicate and mismatched inventory data',
      () {
    const detector = FraudDetectionService();

    final flags = detector.detect(
      const InventoryItem(
        id: 'item-1',
        sku: 'SKU-001',
        barcode: '1234567890123',
        batch: 'B-001',
        expiryDate: '2026-12-31',
      ),
      const InventoryItem(
        id: 'item-2',
        sku: 'SKU-001',
        barcode: '1234567890123',
        batch: 'B-002',
        expiryDate: '2026-11-30',
      ),
    );

    expect(flags, contains('Duplicate Barcode'));
    expect(flags, contains('Batch Mismatch'));
    expect(flags, contains('Production Date Mismatch'));
  });
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
