import '../../domain/models/inventory_item.dart';

class FraudDetectionService {
  const FraudDetectionService();

  List<String> detect(InventoryItem current, InventoryItem candidate) {
    final flags = <String>[];

    if (current.barcode.isNotEmpty && current.barcode == candidate.barcode) {
      flags.add('Duplicate Barcode');
    }

    if (current.batch.isNotEmpty && current.batch != candidate.batch) {
      flags.add('Batch Mismatch');
    }

    if (current.expiryDate.isNotEmpty &&
        current.expiryDate != candidate.expiryDate) {
      flags.add('Production Date Mismatch');
    }

    return flags;
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
